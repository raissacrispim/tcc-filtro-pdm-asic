# ============================================================
# golden_model.py
# Golden Model do filtro PDM CIC + FIR compensador
#
# Versao em script do notebook 05_Golden_Model_v2.ipynb, com a
# correcao da largura do CIC (v3):
#
#   - A entrada bipolar (-1/+1) exige 2 bits em complemento de 2.
#     Pela formula de Hogenauer, B_max = 2 + N*log2(R*M) = 18 bits.
#   - Com 17 bits, a entrada de fundo de escala positivo (todos os
#     bits PDM em 1) produzia +65536, que sofria wrap para -65536.
#   - Como a saida do CIC e sempre par (y = 2*S - 65536), o bit
#     menos significativo e descartado sem perda de informacao.
#     O FIR continua recebendo 17 bits (formato Q1.15).
#
# Uso (a partir da raiz do repositorio):
#
#   python3 golden_model/golden_model.py
#
# Gera os vetores oficiais em vectors/.
# ============================================================

import os

import numpy as np


# ------------------------------------------------------------
# Parametros oficiais
# ------------------------------------------------------------

FS_PDM = 4.8e6

CIC_N = 4
CIC_R = 16
CIC_M = 1

FS_OUT = FS_PDM / CIC_R

# Largura interna do CIC (integradores e combs)
BITS_CIC = 18

# Bits descartados na saida do CIC (LSB sempre zero)
CIC_SHIFT = 1

# Largura entregue ao FIR
BITS_CIC_OUT = BITS_CIC - CIC_SHIFT

FIR_TAPS = 65

BITS_COEF = 16
FRAC_COEF = 15

BITS_ACC_FIR = 34
BITS_SAIDA = 19

N_PDM = 9600


# ------------------------------------------------------------
# Coeficientes do FIR compensador (Q1.15)
# ------------------------------------------------------------

FIR_COEF_Q15 = np.array([
      -6,     -2,     14,    -11,    -22,
      43,     -4,    -80,     82,     56,
    -196,     81,    218,   -330,    -28,
     515,   -404,   -389,    869,   -207,
   -1010,   1065,    394,  -1849,    920,
    1915,  -2661,   -709,   4553,  -2307,
   -6823,  10412,  24614,  10412,  -6823,
   -2307,   4553,   -709,  -2661,   1915,
     920,  -1849,    394,   1065,  -1010,
    -207,    869,   -389,   -404,    515,
     -28,   -330,    218,     81,   -196,
      56,     82,    -80,     -4,     43,
     -22,    -11,     14,     -2,     -6
], dtype=np.int64)

assert len(FIR_COEF_Q15) == FIR_TAPS
assert np.array_equal(FIR_COEF_Q15, FIR_COEF_Q15[::-1])


# ------------------------------------------------------------
# Aritmetica signed
# ------------------------------------------------------------

def wrap_signed(x, bits):
    """Wrap modular em complemento de dois."""

    modulo = 2 ** bits
    metade = 2 ** (bits - 1)

    return ((int(x) + metade) % modulo) - metade


def sat_signed(x, bits):
    """Saturacao signed."""

    minimo = -(2 ** (bits - 1))
    maximo = (2 ** (bits - 1)) - 1

    return min(max(int(x), minimo), maximo)


def round_shift_signed(x, shift):
    """Divide por 2**shift com arredondamento simetrico."""

    x = int(x)

    metade = 1 << (shift - 1)

    if x >= 0:
        return (x + metade) >> shift
    else:
        return -(((-x) + metade) >> shift)


# ------------------------------------------------------------
# CIC
# ------------------------------------------------------------

def cic_fixed_point(pdm_bits):
    """
    CIC decimador.

    Entrada:
        bits PDM (0 ou 1), convertidos para -1/+1

    Processamento:
        N = 4, R = 16, M = 1
        integradores e combs com wrap de 18 bits

    Saida:
        signed de 17 bits (saida do comb >> 1)
        taxa = FS_PDM / R
    """

    pdm_bits = np.asarray(pdm_bits, dtype=np.int8)

    if not np.all((pdm_bits == 0) | (pdm_bits == 1)):
        raise ValueError("A entrada PDM deve conter somente 0 e 1.")

    integradores = [0] * CIC_N
    comb_delay = [0] * CIC_N

    saida = []

    for n, bit in enumerate(pdm_bits):

        x = 1 if bit == 1 else -1

        # Integradores - 4,8 MHz
        for estagio in range(CIC_N):

            if estagio == 0:
                entrada_estagio = x
            else:
                entrada_estagio = integradores[estagio - 1]

            integradores[estagio] = wrap_signed(
                integradores[estagio] + entrada_estagio,
                BITS_CIC
            )

        # Decimacao por R
        if (n + 1) % CIC_R != 0:
            continue

        y = integradores[-1]

        # Combs - 300 kHz
        for estagio in range(CIC_N):

            diferenca = y - comb_delay[estagio]

            comb_delay[estagio] = y

            y = wrap_signed(diferenca, BITS_CIC)

        # Com entrada -1/+1 a saida e sempre par
        assert y % 2 == 0

        saida.append(y >> CIC_SHIFT)

    return np.asarray(saida, dtype=np.int64)


# ------------------------------------------------------------
# FIR
# ------------------------------------------------------------

def fir_fixed_point(x):
    """
    FIR compensador.

    Entrada:      signed de 17 bits
    Coeficientes: 65 taps, Q1.15
    Acumulador:   34 bits signed
    Saida:        arredondamento simetrico Q15, 19 bits signed
    """

    x = np.asarray(x, dtype=np.int64)

    y = np.zeros(len(x), dtype=np.int64)

    for n in range(len(x)):

        acc = 0

        for k in range(FIR_TAPS):

            idx = n - k

            if idx >= 0:
                acc += int(x[idx]) * int(FIR_COEF_Q15[k])

        acc = sat_signed(acc, BITS_ACC_FIR)

        y_temp = round_shift_signed(acc, FRAC_COEF)

        y[n] = sat_signed(y_temp, BITS_SAIDA)

    return y


def golden_model(pdm_bits):
    """Cadeia completa: PDM 4,8 MHz -> saida de 19 bits a 300 kHz."""

    return fir_fixed_point(cic_fixed_point(pdm_bits))


# ------------------------------------------------------------
# Geracao de estimulos
# ------------------------------------------------------------

def sigma_delta_1bit(x):
    """Modulador sigma-delta de 1a ordem (somente estimulos)."""

    x = np.asarray(x, dtype=float)

    pdm = np.zeros(len(x), dtype=np.int8)

    integrador = 0.0
    y_prev = 0.0

    for n in range(len(x)):

        integrador += x[n] - y_prev

        if integrador >= 0:
            y = 1.0
            pdm[n] = 1
        else:
            y = -1.0
            pdm[n] = 0

        y_prev = y

    return pdm


def eixo_tempo(duracao=0.002):

    return np.arange(0, duracao, 1 / FS_PDM)


def gerar_pdm_seno(freq, amplitude=0.8, duracao=0.002):

    t = eixo_tempo(duracao)

    return sigma_delta_1bit(amplitude * np.sin(2 * np.pi * freq * t))


def gerar_pdm_50k_ruido():

    np.random.seed(1234)

    t = eixo_tempo()

    sinal = 0.7 * np.sin(2 * np.pi * 50e3 * t)
    sinal = sinal + 0.08 * np.random.randn(len(t))

    return sigma_delta_1bit(np.clip(sinal, -1.0, 1.0))


def gerar_pdm_burst():

    np.random.seed(5678)

    t = eixo_tempo()

    janela = ((t >= 0.0005) & (t < 0.0015)).astype(float)

    sinal = 0.7 * janela * np.sin(2 * np.pi * 50e3 * t)
    sinal = sinal + 0.08 * np.random.randn(len(t))

    return sigma_delta_1bit(np.clip(sinal, -1.0, 1.0))


def gerar_pdm_fundo_escala():
    """
    Teste de fundo de escala: blocos de 2400 bits alternando
    entre todos em 0 (-1) e todos em 1 (+1).

    Exercita os extremos -65536 e +65536 do CIC de 18 bits,
    que no CIC de 17 bits resultavam ambos em -65536.
    """

    bloco = N_PDM // 4

    return np.concatenate([
        np.zeros(bloco, dtype=np.int8),
        np.ones(bloco, dtype=np.int8),
        np.zeros(bloco, dtype=np.int8),
        np.ones(bloco, dtype=np.int8),
    ])


def gerar_testes():

    return {
        "test_01_10k": gerar_pdm_seno(10e3),
        "test_02_30k": gerar_pdm_seno(30e3),
        "test_03_50k": gerar_pdm_seno(50e3),
        "test_04_80k": gerar_pdm_seno(80e3),
        "test_05_50k_ruido": gerar_pdm_50k_ruido(),
        "test_06_burst_50k_ruido": gerar_pdm_burst(),
        "test_07_fundo_escala": gerar_pdm_fundo_escala(),
    }


# ------------------------------------------------------------
# Exportacao dos vetores
# ------------------------------------------------------------

def salvar(caminho, valores):

    np.savetxt(caminho, np.asarray(valores, dtype=np.int64), fmt="%d")


def exportar_vetores(pasta):

    os.makedirs(pasta, exist_ok=True)

    out_min = -(2 ** (BITS_SAIDA - 1))
    out_max = (2 ** (BITS_SAIDA - 1)) - 1

    cic_min = -(2 ** (BITS_CIC_OUT - 1))
    cic_max = (2 ** (BITS_CIC_OUT - 1)) - 1

    print("Teste                      | PDM  | Saida | CIC min/max     | Saida min/max")
    print("-" * 82)

    for nome, pdm in gerar_testes().items():

        assert len(pdm) == N_PDM

        cic_out = cic_fixed_point(pdm)
        y = fir_fixed_point(cic_out)

        assert len(cic_out) == N_PDM // CIC_R
        assert cic_out.min() >= cic_min and cic_out.max() <= cic_max
        assert y.min() >= out_min and y.max() <= out_max

        base = os.path.join(pasta, nome)

        salvar(f"{base}_input_pdm.txt", pdm)
        salvar(f"{base}_output_cic_golden.txt", cic_out)
        salvar(f"{base}_input_fir.txt", cic_out)
        salvar(f"{base}_output_fir_golden.txt", y)
        salvar(f"{base}_output_golden.txt", y)

        print(
            f"{nome:26s} | {len(pdm):4d} | {len(y):5d} | "
            f"{cic_out.min():6d} / {cic_out.max():6d} | "
            f"{y.min():7d} / {y.max():7d}"
        )

    salvar(os.path.join(pasta, "fir_coef_q15.txt"), FIR_COEF_Q15)

    with open(os.path.join(pasta, "golden_model_config.txt"), "w") as f:

        f.write("GOLDEN MODEL - CIC + FIR\n")
        f.write("========================\n")
        f.write(f"FS_PDM_HZ={int(FS_PDM)}\n")
        f.write(f"FS_OUT_HZ={int(FS_OUT)}\n")
        f.write(f"CIC_N={CIC_N}\n")
        f.write(f"CIC_R={CIC_R}\n")
        f.write(f"CIC_M={CIC_M}\n")
        f.write(f"BITS_CIC={BITS_CIC}\n")
        f.write(f"CIC_SHIFT={CIC_SHIFT}\n")
        f.write(f"BITS_CIC_OUT={BITS_CIC_OUT}\n")
        f.write(f"FIR_TAPS={FIR_TAPS}\n")
        f.write(f"BITS_COEF={BITS_COEF}\n")
        f.write(f"FRAC_COEF={FRAC_COEF}\n")
        f.write(f"BITS_ACC_FIR={BITS_ACC_FIR}\n")
        f.write(f"BITS_SAIDA={BITS_SAIDA}\n")


if __name__ == "__main__":

    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

    exportar_vetores(os.path.join(raiz, "vectors"))

    print()
    print("Vetores gerados em vectors/.")
