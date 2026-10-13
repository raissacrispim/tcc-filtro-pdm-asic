#!/usr/bin/env python3
# ============================================================
# plot_resultados.py
# Figuras de verificacao do filtro PDM (CIC + FIR)
#
# Uso (a partir da raiz do repositorio):
#
#   python3 golden_model/plot_resultados.py
#
# Le os vetores de vectors/ e gera em docs/figuras/:
#
#   resposta_frequencia.png  resposta do CIC, do FIR e total
#   teste_<nome>.png         entrada PDM, saida do Golden Model
#                            x saida do chip e diferenca
#   espectro_<nome>.png      espectro da saida (FFT)
#   resumo_testes.png        amostras comparadas e erros
#   filtragem_<nome>.png     entrada PDM -> CIC -> FIR, no tempo e
#                            no espectro (teste com interferencia)
#
# "Saida do chip" e o arquivo *_output_rtl.txt escrito pelo
# testbench na ultima simulacao executada (RTL, gate-level ou
# pos-layout com SDF). Para figuras do chip final, execute
# antes a regressao pos-layout:
#
#   sim/scripts/compile_gls.sh pnr sdf
#   sim/scripts/run_gls_regression.sh
# ============================================================

import os

import matplotlib

matplotlib.use("Agg")

import matplotlib.pyplot as plt
import numpy as np

RAIZ = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
VETORES = os.path.join(RAIZ, "vectors")
FIGURAS = os.path.join(RAIZ, "docs", "figuras")

FS_PDM = 4.8e6
R = 16
N_CIC = 4
FS_OUT = FS_PDM / R
BITS_SAIDA = 19

FAIXA_PASSAGEM = 80e3
FAIXA_REJEICAO = 110e3

TESTES = {
    "test_01_10k": "Senoide de 10 kHz",
    "test_02_30k": "Senoide de 30 kHz",
    "test_03_50k": "Senoide de 50 kHz",
    "test_04_80k": "Senoide de 80 kHz",
    "test_05_50k_ruido": "50 kHz com ruido",
    "test_06_burst_50k_ruido": "Burst de 50 kHz com ruido",
    "test_07_fundo_escala": "Fundo de escala",
    "test_08_50k_interf_130k": "50 kHz + interferencia de 130 kHz",
}

plt.rcParams.update({
    "figure.dpi": 150,
    "font.size": 9,
    "axes.grid": True,
    "grid.alpha": 0.3,
})


def ler(nome):
    caminho = os.path.join(VETORES, nome)
    if not os.path.exists(caminho):
        return None
    with open(caminho) as f:
        return np.array([int(l) for l in f if l.strip()], dtype=np.int64)


def resposta_frequencia():
    coef = ler("fir_coef_q15.txt")
    if coef is None:
        return
    h_fir = coef / 2**15

    # CIC na taxa de entrada (4,8 MHz), normalizado em DC
    f = np.linspace(1, FS_PDM / 2, 20000)
    x = np.pi * f / FS_PDM
    h_cic = np.abs(np.sin(R * x) / (R * np.sin(x))) ** N_CIC

    # FIR na taxa de saida (300 kHz), resposta periodica
    w = 2 * np.pi * f / FS_OUT
    n = np.arange(len(h_fir))
    h_f = np.abs(np.exp(-1j * np.outer(w, n)) @ h_fir)
    h_f /= h_f[0]

    db = lambda h: 20 * np.log10(np.maximum(h, 1e-12))

    fig, (a1, a2) = plt.subplots(1, 2, figsize=(10, 3.6))

    for eixo, limite in ((a1, FS_OUT * 1.5), (a2, FAIXA_PASSAGEM * 1.1)):
        sel = f <= limite
        eixo.plot(f[sel] / 1e3, db(h_cic[sel]), label="CIC (N=4, R=16)", lw=1)
        eixo.plot(f[sel] / 1e3, db(h_f[sel]), label="FIR compensador", lw=1)
        eixo.plot(f[sel] / 1e3, db(h_cic[sel] * h_f[sel]),
                  label="CIC + FIR", lw=1.6, color="k")
        eixo.axvline(FAIXA_PASSAGEM / 1e3, ls="--", color="g", lw=0.8)
        eixo.set_xlabel("Frequencia (kHz)")
        eixo.set_ylabel("Magnitude (dB)")

    a1.axvline(FAIXA_REJEICAO / 1e3, ls="--", color="r", lw=0.8)
    a1.axhline(-80, ls=":", color="r", lw=0.8)
    # Faixas que, apos a decimacao para 300 kHz, dobram sobre a
    # faixa de passagem (300 kHz +- 80 kHz): atenuadas so pelo CIC
    a1.axvspan((FS_OUT - FAIXA_PASSAGEM) / 1e3,
               min(FS_OUT + FAIXA_PASSAGEM, FS_OUT * 1.5) / 1e3,
               color="0.85", zorder=0,
               label="dobra sobre 0-80 kHz apos decimar")
    a1.set_ylim(-120, 10)
    a1.set_title("Resposta em frequencia")
    a1.legend(loc="lower left", fontsize=7)

    sel = f <= FAIXA_PASSAGEM
    total = db(h_cic[sel] * h_f[sel])
    a2.set_ylim(-0.5, 0.5)
    a2.set_title("Faixa de passagem: ondulacao de "
                 f"{total.max() - total.min():.2f} dB p-p")

    fig.tight_layout()
    fig.savefig(os.path.join(FIGURAS, "resposta_frequencia.png"))
    plt.close(fig)


def figura_teste(nome, titulo):
    pdm = ler(f"{nome}_input_pdm.txt")
    gold = ler(f"{nome}_output_golden.txt")
    chip = ler(f"{nome}_output_rtl.txt")
    if pdm is None or gold is None:
        return None

    t_pdm = np.arange(len(pdm)) / FS_PDM * 1e3
    t_out = np.arange(len(gold)) / FS_OUT * 1e3
    escala = 2 ** (BITS_SAIDA - 1)

    fig, eixos = plt.subplots(4, 1, figsize=(9, 9), sharex=False)

    # Entrada PDM: trecho dos bits e media movel (sinal analogico)
    trecho = t_pdm <= 0.1
    eixos[0].step(t_pdm[trecho], pdm[trecho], where="post",
                  lw=0.5, color="0.6", label="bits PDM")
    media = np.convolve(2 * pdm - 1, np.ones(64) / 64, mode="same")
    eixos[0].plot(t_pdm[trecho], (media[trecho] + 1) / 2,
                  color="C0", lw=1.2, label="media movel de 64 bits")
    eixos[0].set_title(f"{titulo}: entrada PDM (1 bit, 4,8 MHz), primeiros 0,1 ms")
    eixos[0].set_xlabel("Tempo (ms)")
    eixos[0].legend(loc="upper right", fontsize=7)

    # Saida: Golden Model x chip
    eixos[1].plot(t_out, gold / escala, color="k", lw=1.6,
                  label="Golden Model (Python)")
    if chip is not None and len(chip) == len(gold):
        eixos[1].plot(t_out, chip / escala, "o", ms=2, color="C1",
                      label="Saida do chip (simulacao)")
    eixos[1].set_title("Saida do filtro (19 bits, 300 kHz), normalizada")
    eixos[1].set_xlabel("Tempo (ms)")
    eixos[1].legend(loc="upper right", fontsize=7)

    # Detalhe de 0,2 ms da saida, apos o transitorio
    janela = (t_out >= 1.0) & (t_out <= 1.2)
    eixos[2].plot(t_out[janela], gold[janela] / escala, color="k", lw=1.6,
                  label="Golden Model (Python)")
    if chip is not None and len(chip) == len(gold):
        eixos[2].plot(t_out[janela], chip[janela] / escala, "o", ms=4,
                      color="C1", label="Saida do chip (simulacao)")
    eixos[2].set_title("Detalhe da saida (1,0 a 1,2 ms)")
    eixos[2].set_xlabel("Tempo (ms)")
    eixos[2].legend(loc="upper right", fontsize=7)

    # Diferenca
    erros = None
    if chip is not None and len(chip) == len(gold):
        dif = chip - gold
        erros = int(np.count_nonzero(dif))
        eixos[3].plot(t_out, dif, color="C3", lw=1)
        eixos[3].set_ylim(-2, 2)
        eixos[3].set_title(f"Diferenca chip - Golden Model: {erros} erros "
                           f"em {len(gold)} amostras")
    else:
        eixos[3].set_title("Saida do chip nao encontrada")
    eixos[3].set_xlabel("Tempo (ms)")
    eixos[3].set_ylabel("LSB")

    fig.tight_layout()
    fig.savefig(os.path.join(FIGURAS, f"teste_{nome}.png"))
    plt.close(fig)

    return len(gold), erros


def figura_espectro(nome, titulo):
    chip = ler(f"{nome}_output_rtl.txt")
    gold = ler(f"{nome}_output_golden.txt")
    sinal = chip if chip is not None else gold
    if sinal is None:
        return

    # Descarta o transitorio inicial (atraso do CIC + FIR)
    x = sinal[80:] / 2 ** (BITS_SAIDA - 1)
    x = x - x.mean()
    janela = np.blackman(len(x))
    X = np.abs(np.fft.rfft(x * janela)) / (janela.sum() / 2)
    f = np.fft.rfftfreq(len(x), 1 / FS_OUT)

    fig, eixo = plt.subplots(figsize=(8, 3.4))
    eixo.plot(f / 1e3, 20 * np.log10(np.maximum(X, 1e-9)), lw=1)
    eixo.axvline(FAIXA_PASSAGEM / 1e3, ls="--", color="g", lw=0.8,
                 label="fim da faixa de passagem (80 kHz)")
    eixo.set_xlabel("Frequencia (kHz)")
    eixo.set_ylabel("Magnitude (dBFS)")
    eixo.set_ylim(-140, 5)
    eixo.set_title(f"Espectro da saida do chip: {titulo}")
    eixo.legend(fontsize=7)
    fig.tight_layout()
    fig.savefig(os.path.join(FIGURAS, f"espectro_{nome}.png"))
    plt.close(fig)


def espectro_db(x, fs):
    x = np.asarray(x, dtype=float)
    x = x - x.mean()
    janela = np.blackman(len(x))
    X = np.abs(np.fft.rfft(x * janela)) / (janela.sum() / 2)
    return np.fft.rfftfreq(len(x), 1 / fs), 20 * np.log10(np.maximum(X, 1e-9))


def figura_filtragem(nome, titulo, tons):
    """Entrada PDM -> saida do CIC -> saida do FIR, no tempo e na frequencia."""
    pdm = ler(f"{nome}_input_pdm.txt")
    cic = ler(f"{nome}_output_cic_golden.txt")
    gold = ler(f"{nome}_output_golden.txt")
    chip = ler(f"{nome}_output_rtl.txt")
    if pdm is None or cic is None or gold is None:
        return
    saida = chip if chip is not None and len(chip) == len(gold) else gold
    origem = "chip" if saida is chip else "Golden Model"

    fig, eixos = plt.subplots(3, 2, figsize=(11, 8))

    # Tempo: detalhe de 0,1 ms apos o transitorio
    t_out = np.arange(len(gold)) / FS_OUT * 1e3
    t_pdm = np.arange(len(pdm)) / FS_PDM * 1e3
    jan_out = (t_out >= 1.0) & (t_out <= 1.1)
    jan_pdm = (t_pdm >= 1.0) & (t_pdm <= 1.1)

    eixos[0, 0].step(t_pdm[jan_pdm], pdm[jan_pdm], where="post", lw=0.6,
                     color="0.4")
    eixos[0, 0].set_title("1) Entrada PDM: 1 bit a 4,8 MHz")
    eixos[1, 0].plot(t_out[jan_out], cic[jan_out] / 2 ** 16, "o-", ms=3,
                     color="C0")
    eixos[1, 0].set_title("2) Saida do CIC (300 kHz): 50 kHz + 130 kHz")
    eixos[2, 0].plot(t_out[jan_out], saida[jan_out] / 2 ** 16, "o-", ms=3,
                     color="C2")
    eixos[2, 0].set_title(f"3) Saida do FIR ({origem}): somente 50 kHz")
    eixos[2, 0].set_xlabel("Tempo (ms)")

    # Frequencia
    f, X = espectro_db(2 * pdm - 1, FS_PDM)
    eixos[0, 1].plot(f / 1e3, X, lw=0.6, color="0.4")
    eixos[0, 1].set_xlim(0, 1200)
    eixos[0, 1].set_title("Espectro da entrada PDM (ruido de quantizacao "
                          "cresce com a frequencia)")
    f, X = espectro_db(cic[80:] / 2 ** 16, FS_OUT)
    eixos[1, 1].plot(f / 1e3, X, lw=1, color="C0")
    eixos[1, 1].set_title("Espectro apos o CIC")
    f, X = espectro_db(saida[80:] / 2 ** 16, FS_OUT)
    eixos[2, 1].plot(f / 1e3, X, lw=1, color="C2")
    eixos[2, 1].set_title("Espectro apos o FIR: interferencia removida")
    eixos[2, 1].set_xlabel("Frequencia (kHz)")

    for eixo in eixos[:, 1]:
        eixo.set_ylim(-140, 5)
        eixo.set_ylabel("dBFS")
        for tom in tons:
            eixo.axvline(tom / 1e3, ls=":", color="r", lw=0.8)
    for eixo in eixos[1:, 1]:
        eixo.set_xlim(0, FS_OUT / 2 / 1e3)
        eixo.axvspan(FAIXA_PASSAGEM / 1e3, FAIXA_REJEICAO / 1e3,
                     color="0.9", zorder=0)

    fig.suptitle(f"Filtragem estagio a estagio: {titulo}")
    fig.tight_layout()
    fig.savefig(os.path.join(FIGURAS, f"filtragem_{nome}.png"))
    plt.close(fig)


def figura_resumo(resultados):
    nomes = list(resultados)
    amostras = [resultados[n][0] for n in nomes]
    erros = [resultados[n][1] if resultados[n][1] is not None else np.nan
             for n in nomes]

    fig, eixo = plt.subplots(figsize=(8, 3.2))
    pos = np.arange(len(nomes))
    eixo.bar(pos - 0.2, amostras, 0.4, label="amostras comparadas")
    eixo.bar(pos + 0.2, erros, 0.4, label="erros", color="C3")
    for p, e in zip(pos, erros):
        eixo.text(p + 0.2, 10, "0" if e == 0 else str(e),
                  ha="center", fontsize=8, color="C3")
    eixo.set_xticks(pos)
    eixo.set_xticklabels([TESTES[n] for n in nomes], rotation=20,
                         ha="right", fontsize=7)
    eixo.set_title("Chip x Golden Model: amostras comparadas e erros por teste")
    eixo.legend(fontsize=7)
    fig.tight_layout()
    fig.savefig(os.path.join(FIGURAS, "resumo_testes.png"))
    plt.close(fig)


def main():
    os.makedirs(FIGURAS, exist_ok=True)

    resposta_frequencia()

    resultados = {}
    for nome, titulo in TESTES.items():
        r = figura_teste(nome, titulo)
        if r is not None:
            resultados[nome] = r
            print(f"{nome:28s} amostras {r[0]:4d}   erros {r[1]}")

    for nome in ("test_03_50k", "test_05_50k_ruido"):
        figura_espectro(nome, TESTES[nome])

    figura_filtragem("test_08_50k_interf_130k",
                     TESTES["test_08_50k_interf_130k"], (50e3, 130e3))

    if resultados:
        figura_resumo(resultados)

    print(f"Figuras em {os.path.relpath(FIGURAS, RAIZ)}/")


if __name__ == "__main__":
    main()
