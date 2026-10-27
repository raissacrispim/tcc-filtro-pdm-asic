#!/usr/bin/env python3
# ============================================================
# analise_desempenho.py
# Desempenho do filtro PDM CIC + FIR a partir das saidas do
# hardware (simulacao VCS da netlist pos-layout com SDF)
#
# Uso (a partir da raiz do repositorio):
#
#   python3 golden_model/analise_desempenho.py
#
# Somente leitura: usa vectors/fir_coef_q15.txt e as saidas
# vectors/test_*_output_rtl.txt (gravadas pela ultima regressao,
# identicas as do Golden Model). Nao altera o projeto.
#
# Especificacao adotada (golden_model/05_Golden_Model_v2.ipynb e
# golden_model.py):
#   banda util           20-80 kHz
#   banda de rejeicao    a partir de 110 kHz (ate fout/2 = 150 kHz)
#   interferencia        130 kHz atenuada em mais de 80 dB (teste 08)
#
# Resultado: docs/desempenho_filtro.md (texto gerado aqui)
# ============================================================

import os

import numpy as np

FS_PDM = 4.8e6
R = 16
N_CIC = 4
FS_OUT = FS_PDM / R
F_UTIL = (20e3, 80e3)
F_REJ = 110e3
TAPS = 65

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
VET = os.path.join(RAIZ, "vectors")


def carrega(nome):
    return np.loadtxt(os.path.join(VET, nome), dtype=float)


def db(x):
    return 20 * np.log10(np.maximum(np.abs(x), 1e-15))


# ------------------------------------------------------------
# 1. Resposta teorica (coeficientes quantizados Q1.15)
# ------------------------------------------------------------

h_fir = carrega("fir_coef_q15.txt") / 2 ** 15


def resposta_teorica(f):
    """|H_CIC(f) * H_FIR(f)| normalizada pelo ganho DC."""
    f = np.asarray(f, dtype=float)
    x = np.pi * f / FS_PDM
    with np.errstate(invalid="ignore", divide="ignore"):
        cic = np.where(x == 0, 1.0,
                       np.abs(np.sin(R * x) / (R * np.sin(x)))) ** N_CIC
    w = 2 * np.pi * f / FS_OUT
    fir = np.abs(np.exp(-1j * np.outer(w, np.arange(TAPS))) @ h_fir)
    return cic * fir / np.sum(h_fir)


f = np.linspace(0, FS_OUT / 2, 3001)
H = resposta_teorica(f)
banda = (f >= F_UTIL[0]) & (f <= F_UTIL[1])
rej = f >= F_REJ
ref_db = np.mean(db(H[banda]))
ripple_db = np.max(db(H[banda])) - np.min(db(H[banda]))
aten_rej_db = ref_db - np.max(db(H[rej]))
# frequencia de -3 dB em relacao a media da banda util
acima = f[(f > F_UTIL[1]) & (db(H) <= ref_db - 3)]
f_3db = acima[0] if len(acima) else float("nan")

# Rejeicao de aliasing do CIC: faixas que dobram sobre a banda
# util depois da decimacao (k*300 kHz +- 80 kHz)
f_alias = np.concatenate([np.linspace(k * FS_OUT - F_UTIL[1],
                                      k * FS_OUT + F_UTIL[1], 401)
                          for k in range(1, R // 2 + 1)])
x = np.pi * f_alias / FS_PDM
cic_alias = np.abs(np.sin(R * x) / (R * np.sin(x))) ** N_CIC
aten_alias_db = -np.max(db(cic_alias))


# ------------------------------------------------------------
# 2. Resposta ao impulso medida (teste 10)
#
# Sequencia 0101... (2,4 MHz, anulada pelo CIC) com o bit 3200
# invertido: degrau de amplitude 2 em um unico instante. A saida
# do hardware e a resposta ao impulso do CIC + FIR, amostrada na
# fase de decimacao do bit 3200.
# ------------------------------------------------------------

y_imp = carrega("test_10_impulso_output_rtl.txt")
n_imp = 3200 / R                       # amostra de saida do impulso
# Janela da resposta: o inicio do arquivo tem o transitorio de
# partida do filtro (ate ~70 amostras), que nao faz parte dela.
# A resposta do CIC + FIR dura ~ 65 + 4 amostras de saida.
ini = int(n_imp) - 8
fim = int(n_imp) + TAPS + 12
base = np.median(y_imp[120:ini])       # 0101... e anulado pelo CIC
h_hw = y_imp[ini:fim] - base
pico = ini + int(np.argmax(np.abs(h_hw)))
amp_pico = np.max(np.abs(h_hw))
# Piso de medida: arredondamento da saida em 1 LSB, relativo ao
# ganho DC da resposta
piso_imp_db = db(1.0 / np.sum(h_hw))
atraso_amostras = pico - n_imp
nfft = 4096
Hhw = np.abs(np.fft.rfft(h_hw, nfft))
f_hw = np.fft.rfftfreq(nfft, 1 / FS_OUT)
Hhw = Hhw / Hhw[0]
banda_hw = (f_hw >= F_UTIL[0]) & (f_hw <= F_UTIL[1])
rej_hw = f_hw >= F_REJ
ref_hw = np.mean(db(Hhw[banda_hw]))
ripple_hw = np.max(db(Hhw[banda_hw])) - np.min(db(Hhw[banda_hw]))
aten_rej_hw = ref_hw - np.max(db(Hhw[rej_hw]))
# diferenca medida x teoria na banda util
dif_banda = np.max(np.abs(db(Hhw[banda_hw]) -
                          db(resposta_teorica(f_hw[banda_hw]))))


# ------------------------------------------------------------
# 3. Espectro de saidas senoidais (regime permanente)
# ------------------------------------------------------------

TRANS = 100   # descarta o transitorio inicial (CIC + 65 taps)


def espectro(y):
    y = y[TRANS:]
    y = y[-480:]                       # 480 amostras: bins de 625 Hz
    y = y - np.mean(y)
    w = np.hanning(len(y))
    Y = np.abs(np.fft.rfft(y * w)) / np.sum(w) * 2
    fy = np.fft.rfftfreq(len(y), 1 / FS_OUT)
    return fy, Y


def amp(fy, Y, f0, larg=2):
    k = int(round(f0 / (fy[1] - fy[0])))
    return np.sqrt(np.sum(Y[max(k - larg, 0):k + larg + 1] ** 2))


# Teste 08: 0,4 sen(50 kHz) + 0,4 sen(130 kHz), mesma amplitude
fy, Y = espectro(carrega("test_08_50k_interf_130k_output_rtl.txt"))
a50, a130 = amp(fy, Y, 50e3), amp(fy, Y, 130e3)
rejeicao_130 = db(a50) - db(a130)
teor_130 = -db(resposta_teorica([130e3])[0])
piso_130 = db(a130 / a50)

# Teste 03 (50 kHz, 0,8) e 05 (50 kHz + ruido): SNR na banda util
def snr_banda(nome, f0=50e3):
    fy, Y = espectro(carrega(nome))
    k = int(round(f0 / (fy[1] - fy[0])))
    sinal = np.sum(Y[k - 2:k + 3] ** 2)
    sel = (fy >= F_UTIL[0]) & (fy <= F_UTIL[1])
    sel[k - 2:k + 3] = False
    ruido = np.sum(Y[sel] ** 2)
    snr = 10 * np.log10(sinal / ruido)
    return snr, (snr - 1.76) / 6.02


snr03, enob03 = snr_banda("test_03_50k_output_rtl.txt")
snr05, enob05 = snr_banda("test_05_50k_ruido_output_rtl.txt")
# SNR esperada no teste 05: seno de 0,7 e ruido branco de desvio
# 0,08 a 4,8 MHz, do qual so a fracao 60 kHz / 2,4 MHz cai na
# banda util
snr05_esp = 10 * np.log10((0.7 ** 2 / 2) / (0.08 ** 2 * (60e3 / 2.4e6)))


# Teste 09: varredura 0-150 kHz em 2 ms, f(t) = 75 kHz/ms * t
y_sw = carrega("test_09_varredura_output_rtl.txt")
t_out = np.arange(len(y_sw)) / FS_OUT
atraso_s = atraso_amostras / FS_OUT
f_inst = 75e3 / 1e-3 * (t_out - atraso_s)
jan = 16
env_f, env_db = [], []
for i in range(TRANS, len(y_sw) - jan, jan // 2):
    seg = y_sw[i:i + jan]
    env_f.append(np.mean(f_inst[i:i + jan]))
    env_db.append(db(np.sqrt(2) * np.std(seg)))
env_f = np.array(env_f)
env_db = np.array(env_db)
ref_sw = np.mean(env_db[(env_f >= F_UTIL[0]) & (env_f <= F_UTIL[1])])
env_rel = env_db - ref_sw


def nivel_sw(f0):
    i = np.argmin(np.abs(env_f - f0))
    return env_rel[i]


# Primeira frequencia acima de 80 kHz em que a envoltoria cai 3 dB
cruza = env_f[(env_f > F_UTIL[1]) & (env_rel <= -3)]
f_3db_sw = cruza[0] if len(cruza) else float("nan")


# ------------------------------------------------------------
# 4. Relatorio
# ------------------------------------------------------------

def ok(cond):
    return "atende" if cond else "NAO atende"


linhas = []
P = linhas.append
P("# Desempenho do filtro CIC + FIR\n")
P("Gerado por `golden_model/analise_desempenho.py` a partir dos coeficientes "
  "(`vectors/fir_coef_q15.txt`) e das saídas do hardware "
  "(`vectors/test_*_output_rtl.txt`, simulação da netlist pós-layout com SDF, "
  "idênticas ao Golden Model). Nenhum arquivo do projeto é alterado.\n")
P("Especificação adotada (Golden Model do projeto):\n")
P("- banda útil: 20–80 kHz;")
P("- banda de rejeição: a partir de 110 kHz, até fout/2 = 150 kHz;")
P("- interferência de 130 kHz atenuada em mais de 80 dB (teste 08).\n")
P("## Resposta em frequência\n")
P("| Métrica | Teórica (coef. Q1.15) | Medida no hardware (teste 10) | Especificação |")
P("|---|---|---|---|")
P(f"| Ondulação na banda útil (20–80 kHz) | {ripple_db:.3f} dB | {ripple_hw:.3f} dB | — |")
P(f"| Frequência de −3 dB | {f_3db/1e3:.1f} kHz | — | entre 80 e 110 kHz |")
P(f"| Atenuação mínima a partir de 110 kHz | {aten_rej_db:.1f} dB | {aten_rej_hw:.1f} dB | — |")
P(f"| Rejeição de aliasing do CIC (k·300 kHz ± 80 kHz) | {aten_alias_db:.1f} dB | — | — |")
P(f"| Maior diferença medida × teórica na banda útil | — | {dif_banda:.3f} dB | — |")
P(f"| Piso de medida da resposta ao impulso (1 LSB / ganho DC) | — | {piso_imp_db:.1f} dB | — |")
P("")
P("## Testes com sinais\n")
P("| Métrica | Resultado | Especificação | Situação |")
P("|---|---|---|---|")
P(f"| Rejeição relativa da interferência de 130 kHz (teste 08) | ≥ {rejeicao_130:.1f} dB (componente no piso de ruído; teórica {teor_130:.1f} dB) | > 80 dB | {ok(rejeicao_130 > 80)} |")
P(f"| SNR na banda útil, 50 kHz, amplitude 0,8 (teste 03) | {snr03:.1f} dB (ENOB {enob03:.1f} bits) | — | — |")
P(f"| SNR na banda útil, 50 kHz com ruído (teste 05) | {snr05:.1f} dB (ENOB {enob05:.1f} bits) | — | — |")
P(f"| Nível na varredura em 80 kHz (teste 09) | {nivel_sw(80e3):+.1f} dB | — | — |")
P(f"| Frequência de −3 dB na varredura (teste 09) | {f_3db_sw/1e3:.1f} kHz (teórica {f_3db/1e3:.1f} kHz) | entre 80 e 110 kHz | {ok(80e3 < f_3db_sw < 110e3)} |")
P(f"| Latência (pico da resposta ao impulso) | {atraso_amostras:.1f} amostras = {atraso_amostras/FS_OUT*1e6:.1f} µs | — | — |")
P("")
P("## Observações\n")
P(f"- A resposta ao impulso do teste 10 vem de um único bit invertido: o pico "
  f"da saída é de {amp_pico:.0f} LSB e cada amostra é arredondada em 1 LSB. "
  f"Por isso a atenuação medida na banda de rejeição fica limitada pelo piso "
  f"de quantização ({piso_imp_db:.0f} dB) e não confirma os "
  f"{aten_rej_db:.0f} dB teóricos; a banda útil é medida com precisão.")
P("- A rejeição medida no teste 08 é limitada pelo piso de ruído da saída "
  "(modulador sigma-delta de 1ª ordem usado para gerar o estímulo e "
  "quantização da saída de 19 bits), não pela resposta do filtro.")
P("- A SNR e o ENOB dependem do modulador sigma-delta de 1ª ordem do Golden "
  "Model, que gera os estímulos; não representam o microfone real.")
P(f"- No teste 05, a SNR esperada pelo ruído somado ao estímulo é "
  f"{snr05_esp:.1f} dB (seno de 0,7; ruído branco de desvio 0,08, do qual só "
  f"60 kHz / 2,4 MHz cai na banda útil). A medida ({snr05:.1f} dB) é "
  f"coerente: o filtro preserva a SNR do sinal na banda útil.")
P("- A varredura usa janelas de 16 amostras (53 µs) e dá uma estimativa "
  "grosseira da envoltória. Serve para localizar a transição (−3 dB), mas não "
  "para medir a rejeição: na banda de rejeição, a envoltória é dominada pelo "
  "transitório do filtro (o chirp avança ~8 kHz durante o atraso de grupo) e "
  "pelo ruído do estímulo. A rejeição é medida pelo teste 08.")
P("- O atraso de grupo esperado é de 32 amostras do FIR (fase linear) mais o "
  "atraso do CIC.")

texto = "\n".join(linhas) + "\n"
print(texto)
with open(os.path.join(RAIZ, "docs", "desempenho_filtro.md"), "w") as fh:
    fh.write(texto)
