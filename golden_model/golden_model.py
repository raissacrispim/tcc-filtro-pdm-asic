# ============================================================
# golden_model.py
# Golden Model do filtro PDM: CIC (N=4, R=16, M=1) + FIR de
# 65 coeficientes, em aritmetica de ponto fixo identica ao RTL
#
# Uso (a partir da raiz do repositorio):
#
#   python3 golden_model/golden_model.py
#
# Gera em vectors/, para cada teste:
#   <teste>_input_pdm.txt          bits PDM (0/1), 4,8 MHz
#   <teste>_output_cic_golden.txt  saida do CIC (17 bits), 300 kHz
#   <teste>_input_fir.txt          entrada do FIR (= saida do CIC)
#   <teste>_output_fir_golden.txt  saida do FIR (19 bits)
#   <teste>_output_golden.txt      saida do filtro (= saida do FIR)
# e fir_coef_q15.txt e golden_model_config.txt.
#
# Largura do CIC: a entrada bipolar (-1/+1) ocupa 2 bits e, por
# Hogenauer, B_max = 2 + N*log2(R*M) = 18 bits. A saida do comb
# e sempre par (y = 2*S - 65536), entao o LSB e descartado e o
# FIR recebe 17 bits (Q1.15).
# ============================================================

import os

import numpy as np

FS_PDM = 4.8e6
CIC_N, CIC_R, CIC_M = 4, 16, 1
FS_OUT = FS_PDM / CIC_R
BITS_CIC = 18
CIC_SHIFT = 1
BITS_CIC_OUT = BITS_CIC - CIC_SHIFT
FIR_TAPS = 65
BITS_COEF, FRAC_COEF = 16, 15
BITS_ACC_FIR = 34
BITS_SAIDA = 19
N_PDM = 9600

# Coeficientes do FIR compensador (Q1.15, simetricos)
FIR_COEF_Q15 = np.array([
      -6,     -2,     14,    -11,    -22,     43,     -4,    -80,
      82,     56,   -196,     81,    218,   -330,    -28,    515,
    -404,   -389,    869,   -207,  -1010,   1065,    394,  -1849,
     920,   1915,  -2661,   -709,   4553,  -2307,  -6823,  10412,
   24614,  10412,  -6823,  -2307,   4553,   -709,  -2661,   1915,
     920,  -1849,    394,   1065,  -1010,   -207,    869,   -389,
    -404,    515,    -28,   -330,    218,     81,   -196,     56,
      82,    -80,     -4,     43,    -22,    -11,     14,     -2,
      -6
], dtype=np.int64)

assert len(FIR_COEF_Q15) == FIR_TAPS
assert np.array_equal(FIR_COEF_Q15, FIR_COEF_Q15[::-1])


def wrap(x, bits):
    """Wrap modular em complemento de dois."""
    return ((x + (1 << (bits - 1))) % (1 << bits)) - (1 << (bits - 1))


def sat(x, bits):
    """Saturacao em complemento de dois."""
    return np.clip(x, -(1 << (bits - 1)), (1 << (bits - 1)) - 1)


def cic(pdm):
    """PDM 0/1 a 4,8 MHz -> saida de 17 bits a 300 kHz."""
    pdm = np.asarray(pdm, dtype=np.int64)
    if not np.all((pdm == 0) | (pdm == 1)):
        raise ValueError("A entrada PDM deve conter somente 0 e 1.")

    y = 2 * pdm - 1
    for _ in range(CIC_N):                      # integradores
        y = wrap(np.cumsum(y), BITS_CIC)
    y = y[CIC_R - 1::CIC_R]                     # decimacao
    for _ in range(CIC_N):                      # combs (M = 1)
        y = wrap(np.diff(y, prepend=0), BITS_CIC)

    assert np.all(y % 2 == 0)                   # saida sempre par
    return y >> CIC_SHIFT


def fir(x):
    """FIR Q1.15: acumulador de 34 bits, arredondamento simetrico, 19 bits."""
    acc = sat(np.convolve(x, FIR_COEF_Q15)[:len(x)], BITS_ACC_FIR)
    meio = 1 << (FRAC_COEF - 1)
    y = np.where(acc >= 0, (acc + meio) >> FRAC_COEF,
                 -((-acc + meio) >> FRAC_COEF))
    return sat(y, BITS_SAIDA)


def golden_model(pdm):
    """Cadeia completa: PDM 4,8 MHz -> saida de 19 bits a 300 kHz."""
    return fir(cic(pdm))


# ------------------------------------------------------------
# Estimulos (modulador sigma-delta de 1a ordem, 2 ms)
# ------------------------------------------------------------

def sigma_delta(x):
    pdm = np.zeros(len(x), dtype=np.int8)
    integrador, y_ant = 0.0, 0.0
    for n, amostra in enumerate(x):
        integrador += amostra - y_ant
        pdm[n] = integrador >= 0
        y_ant = 1.0 if pdm[n] else -1.0
    return pdm


T = np.arange(0, 0.002, 1 / FS_PDM)


def seno(f, a=0.8):
    return a * np.sin(2 * np.pi * f * T)


def com_ruido(sinal, semente):
    np.random.seed(semente)
    return np.clip(sinal + 0.08 * np.random.randn(len(T)), -1.0, 1.0)


def impulso():
    """0101... (2,4 MHz, anulado pelo CIC) com um bit invertido."""
    pdm = np.tile(np.array([0, 1], dtype=np.int8), N_PDM // 2)
    pdm[3200] ^= 1
    return pdm


def fundo_escala():
    """Blocos de 2400 bits em 0 e em 1: extremos -65536 e +65536 do CIC."""
    return np.repeat(np.array([0, 1, 0, 1], dtype=np.int8), N_PDM // 4)


def gerar_testes():
    janela = (T >= 0.0005) & (T < 0.0015)
    chirp = 0.7 * np.sin(2 * np.pi * (150e3 / (2 * 0.002)) * T ** 2)
    return {
        "test_01_10k": sigma_delta(seno(10e3)),
        "test_02_30k": sigma_delta(seno(30e3)),
        "test_03_50k": sigma_delta(seno(50e3)),
        "test_04_80k": sigma_delta(seno(80e3)),
        "test_05_50k_ruido": sigma_delta(com_ruido(seno(50e3, 0.7), 1234)),
        "test_06_burst_50k_ruido": sigma_delta(
            com_ruido(janela * seno(50e3, 0.7), 5678)),
        "test_07_fundo_escala": fundo_escala(),
        "test_08_50k_interf_130k": sigma_delta(seno(50e3, 0.4) + seno(130e3, 0.4)),
        "test_09_varredura": sigma_delta(chirp),      # 0 -> 150 kHz em 2 ms
        "test_10_impulso": impulso(),
    }


# ------------------------------------------------------------
# Exportacao
# ------------------------------------------------------------

def salvar(caminho, valores):
    np.savetxt(caminho, np.asarray(valores, dtype=np.int64), fmt="%d")


def exportar_vetores(pasta):
    os.makedirs(pasta, exist_ok=True)
    print("Teste                      | PDM  | Saida | CIC min/max     | Saida min/max")
    print("-" * 82)

    for nome, pdm in gerar_testes().items():
        assert len(pdm) == N_PDM
        c = cic(pdm)
        y = fir(c)
        assert len(c) == N_PDM // CIC_R
        assert np.array_equal(c, wrap(c, BITS_CIC_OUT))   # cabe em 17 bits
        assert np.array_equal(y, wrap(y, BITS_SAIDA))     # cabe em 19 bits

        base = os.path.join(pasta, nome)
        for sufixo, valores in (("input_pdm", pdm), ("output_cic_golden", c),
                                ("input_fir", c), ("output_fir_golden", y),
                                ("output_golden", y)):
            salvar(f"{base}_{sufixo}.txt", valores)

        print(f"{nome:26s} | {len(pdm):4d} | {len(y):5d} | "
              f"{c.min():6d} / {c.max():6d} | {y.min():7d} / {y.max():7d}")

    salvar(os.path.join(pasta, "fir_coef_q15.txt"), FIR_COEF_Q15)

    config = {
        "FS_PDM_HZ": int(FS_PDM), "FS_OUT_HZ": int(FS_OUT),
        "CIC_N": CIC_N, "CIC_R": CIC_R, "CIC_M": CIC_M,
        "BITS_CIC": BITS_CIC, "CIC_SHIFT": CIC_SHIFT,
        "BITS_CIC_OUT": BITS_CIC_OUT, "FIR_TAPS": FIR_TAPS,
        "BITS_COEF": BITS_COEF, "FRAC_COEF": FRAC_COEF,
        "BITS_ACC_FIR": BITS_ACC_FIR, "BITS_SAIDA": BITS_SAIDA,
    }
    with open(os.path.join(pasta, "golden_model_config.txt"), "w") as f:
        f.write("GOLDEN MODEL - CIC + FIR\n========================\n")
        f.writelines(f"{k}={v}\n" for k, v in config.items())


if __name__ == "__main__":
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    exportar_vetores(os.path.join(raiz, "vectors"))
    print("\nVetores gerados em vectors/.")
