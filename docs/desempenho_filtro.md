# Desempenho do filtro CIC + FIR

Gerado por `golden_model/analise_desempenho.py` a partir dos coeficientes (`vectors/fir_coef_q15.txt`) e das saídas do hardware (`vectors/test_*_output_rtl.txt`, simulação da netlist pós-layout com SDF, idênticas ao Golden Model). Nenhum arquivo do projeto é alterado.

Especificação adotada (Golden Model do projeto):

- banda útil: 20–80 kHz;
- banda de rejeição: a partir de 110 kHz, até fout/2 = 150 kHz;
- interferência de 130 kHz atenuada em mais de 80 dB (teste 08).

## Resposta em frequência

| Métrica | Teórica (coef. Q1.15) | Medida no hardware (teste 10) | Especificação |
|---|---|---|---|
| Ondulação na banda útil (20–80 kHz) | 0.175 dB | 0.235 dB | — |
| Frequência de −3 dB | 88.8 kHz | — | entre 80 e 110 kHz |
| Atenuação mínima a partir de 110 kHz | 88.0 dB | 60.6 dB | — |
| Rejeição de aliasing do CIC (k·300 kHz ± 80 kHz) | 39.2 dB | — | — |
| Maior diferença medida × teórica na banda útil | — | 0.164 dB | — |
| Piso de medida da resposta ao impulso (1 LSB / ganho DC) | — | -72.3 dB | — |

## Testes com sinais

| Métrica | Resultado | Especificação | Situação |
|---|---|---|---|
| Rejeição relativa da interferência de 130 kHz (teste 08) | ≥ 104.4 dB (componente no piso de ruído; teórica 117.7 dB) | > 80 dB | atende |
| SNR na banda útil, 50 kHz, amplitude 0,8 (teste 03) | 62.7 dB (ENOB 10.1 bits) | — | — |
| SNR na banda útil, 50 kHz com ruído (teste 05) | 30.6 dB (ENOB 4.8 bits) | — | — |
| Nível na varredura em 80 kHz (teste 09) | +0.1 dB | — | — |
| Frequência de −3 dB na varredura (teste 09) | 90.6 kHz (teórica 88.8 kHz) | entre 80 e 110 kHz | atende |
| Latência (pico da resposta ao impulso) | 33.0 amostras = 110.0 µs | — | — |

## Observações

- A resposta ao impulso do teste 10 vem de um único bit invertido: o pico da saída é de 2480 LSB e cada amostra é arredondada em 1 LSB. Por isso a atenuação medida na banda de rejeição fica limitada pelo piso de quantização (-72 dB) e não confirma os 88 dB teóricos; a banda útil é medida com precisão.
- A rejeição medida no teste 08 é limitada pelo piso de ruído da saída (modulador sigma-delta de 1ª ordem usado para gerar o estímulo e quantização da saída de 19 bits), não pela resposta do filtro.
- A SNR e o ENOB dependem do modulador sigma-delta de 1ª ordem do Golden Model, que gera os estímulos; não representam o microfone real.
- No teste 05, a SNR esperada pelo ruído somado ao estímulo é 31.9 dB (seno de 0,7; ruído branco de desvio 0,08, do qual só 60 kHz / 2,4 MHz cai na banda útil). A medida (30.6 dB) é coerente: o filtro preserva a SNR do sinal na banda útil.
- A varredura usa janelas de 16 amostras (53 µs) e dá uma estimativa grosseira da envoltória. Serve para localizar a transição (−3 dB), mas não para medir a rejeição: na banda de rejeição, a envoltória é dominada pelo transitório do filtro (o chirp avança ~8 kHz durante o atraso de grupo) e pelo ruído do estímulo. A rejeição é medida pelo teste 08.
- O atraso de grupo esperado é de 32 amostras do FIR (fase linear) mais o atraso do CIC.
