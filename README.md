# Filtro Digital PDM para Sinais Ultrassônicos

Projeto de implementação em hardware de um filtro digital para processamento de sinais ultrassônicos modulados por densidade de pulso (PDM).

O projeto faz parte do desenvolvimento de um ASIC utilizando fluxo baseado em standard cells.

## Arquitetura

A cadeia de processamento implementada é:

PDM 1 bit @ 4,8 MHz
→ conversão 0/1 para -1/+1
→ filtro CIC
→ decimação por 16
→ filtro FIR compensador
→ saída digital de 19 bits @ 300 kHz

### CIC

- Ordem: N = 4
- Fator de decimação: R = 16
- Atraso diferencial: M = 1
- Largura interna: 18 bits
- Largura de saída: 17 bits (Q1.15)
- Frequência de entrada: 4,8 MHz
- Frequência de saída: 300 kHz

A entrada bipolar (-1/+1) ocupa 2 bits em complemento de dois. Pela fórmula de Hogenauer:

B_max = B_in + N·log2(R·M) = 2 + 4·4 = 18 bits

A saída dos combs varia em [-65536, +65536]. Com 17 bits, o fundo de escala positivo (+65536) sofria wrap para -65536, invertendo o sinal.

Com entrada -1/+1, a saída do CIC é sempre par (y = 2·S − 65536). O LSB é descartado sem perda de informação, e o FIR recebe 17 bits na faixa [-32768, +32768], ou seja, em formato Q1.15.

### FIR

- 65 coeficientes
- Coeficientes em Q1.15
- Entrada: 17 bits
- Acumulador: 34 bits
- Saída: 19 bits
- Compensação da queda na banda passante do CIC

## Estrutura

- `rtl/`: módulos SystemVerilog sintetizáveis
- `tb/`: testbenches de verificação
- `golden_model/`: Golden Model em Python
  - `golden_model.py`: modelo oficial e geração dos vetores (`python3 golden_model/golden_model.py`)
  - `05_Golden_Model_v2.ipynb`: notebook de desenvolvimento e análises (versão com CIC de 17 bits)
- `vectors/`: vetores de entrada e resultados do Golden Model

## Verificação

A implementação RTL é comparada amostra por amostra com o Golden Model para sete vetores de teste:

- senoide de 10 kHz
- senoide de 30 kHz
- senoide de 50 kHz
- senoide de 80 kHz
- 50 kHz com ruído
- burst de 50 kHz com ruído
- fundo de escala: blocos de 2.400 bits alternando entre todos em 0 e todos em 1

Cada teste utiliza 9.600 amostras PDM e produz 600 amostras de saída.

Os testes 01 a 06 usam os mesmos estímulos PDM da versão anterior. Após a correção do CIC para 18 bits, os vetores de saída foram regenerados e as saídas `*_output_rtl.txt` devem ser obtidas novamente com o VCS. A síntese, a regressão gate-level e o floorplan também precisam ser refeitos.

## Fluxo de execução

Todos os comandos são executados a partir da raiz do repositório.

| Etapa | Ferramenta | Comando | Executar em |
|---|---|---|---|
| Golden Model e vetores | Python | `python3 golden_model/golden_model.py` | raiz |
| Simulação RTL | VCS | ver comando abaixo | `sim/` |
| Síntese lógica + DFT | Design Compiler | `dc_shell -f synth/scripts/synth.tcl` | raiz |
| Simulação gate-level | VCS | `sim/scripts/compile_gls.sh` e `sim/scripts/run_gls_regression.sh` | raiz |
| ATPG stuck-at | TestMAX ATPG | `atpg/scripts/run_atpg.sh` | raiz |
| Simulação dos vetores ATPG | VCS | `sim/scripts/sim_atpg.sh` | raiz |
| ATPG transition | TestMAX ATPG | `atpg/scripts/run_atpg.sh transition` | raiz |
| Preparação | Fusion Compiler | `fc_shell -f pnr/scripts/setup.tcl` | raiz |
| Floorplan | Fusion Compiler | `fc_shell -f pnr/scripts/floorplan.tcl` | raiz |
| Power plan | Fusion Compiler | `fc_shell -f pnr/scripts/power_plan.tcl` | raiz |
| Placement | Fusion Compiler | `fc_shell -f pnr/scripts/place.tcl` | raiz |
| CTS | Fusion Compiler | `fc_shell -f pnr/scripts/cts.tcl` | raiz |
| Roteamento | Fusion Compiler | `fc_shell -f pnr/scripts/route.tcl` | raiz |
| Finalização, ECO de capacitância e GDSII | Fusion Compiler | `fc_shell -f pnr/scripts/finish.tcl` | raiz |
| SDF para simulação pós-layout | PrimeTime | `sta/scripts/run_sdf_gls.sh` | raiz |
| Simulação pós-layout com SDF | VCS | `sim/scripts/compile_gls.sh pnr sdf` e `sim/scripts/run_gls_regression.sh` | raiz |
| Atividade de chaveamento (SAIF) | VCS | `sim/scripts/run_saif.sh` | raiz |
| Potência com SAIF | Fusion Compiler | `fc_shell -f pnr/scripts/power_saif.tcl` | raiz |
| Timing multi-corner (tt/ss/ff) | PrimeTime | `sta/scripts/run_sta.sh` | raiz |
| ATPG pós-layout | TestMAX ATPG | `atpg/scripts/run_atpg.sh stuck pnr` e `atpg/scripts/run_atpg.sh transition pnr` | raiz |
| Verificação do GDS | Python | `python3 pnr/scripts/check_gds.py pnr/output/filtro_pdm_final.gds` | raiz |
| DRC | IC Validator | `verif/scripts/run_drc.sh` | raiz |
| LVS | IC Validator | `verif/scripts/run_lvs.sh` | raiz |

Simulação RTL (dentro de `sim/`):

```bash
vcs -full64 -sverilog -kdb -debug_access+all \
    ../rtl/integrador.sv ../rtl/cic_integradores.sv ../rtl/decimador.sv \
    ../rtl/comb.sv ../rtl/cic_combs.sv ../rtl/cic.sv ../rtl/fir.sv \
    ../rtl/filtro_pdm.sv ../tb/tb_filtro_pdm_golden.sv \
    -o simv_filtro_rtl -l compile_rtl.log
./simv_filtro_rtl +TEST=test_01_10k
```

### DFT

A síntese insere uma cadeia de scan única (flip-flops com multiplexador) e cria as portas `scan_en`, `scan_in` e `scan_out`. Em operação normal, `scan_en = 0`. O RTL funcional não possui essas portas; o testbench as conecta somente quando compilado com `+define+DFT` (simulação gate-level).

As restrições de timing ficam em `pnr/constraints/filtro_pdm_physical.sdc` e são lidas tanto na síntese quanto no Fusion Compiler.

As restrições das portas de scan ficam em `pnr/constraints/filtro_pdm_dft.sdc`.

## Resultados

Tecnologia SAED32 1P9M RVT, corner típico tt0p85v25c, clock de 4,8 MHz.

| Etapa | Resultado |
|---|---|
| Simulação RTL x Golden Model | 7/7 testes aprovados |
| Simulação gate-level pós-síntese | 7/7 testes aprovados |
| Simulação pós-layout com SDF (PrimeTime) | 10/10 testes aprovados; anotação sem erros ou avisos; 0 violações de timing |
| DFT | 1 cadeia de scan, 1.332 flip-flops |
| ATPG pós-layout | stuck-at 98,56%; transition 97,87% |
| DRC (IC Validator) | CLEAN (396 regras) |
| LVS (IC Validator) | PASS |
| Área de células | 40.332 µm² (utilização do core 84%) |
| Células | 9.932 (sem fillers) |
| Capacitância/transição máximas | 0 violações |
| Setup (tt / ss / ff) | +60,1 / +56,6 / +61,8 ns |
| Hold registrador→registrador (tt / ss / ff) | atendido nos três corners |
| Potência dinâmica (SAIF, sinal de 50 kHz com ruído) | 53,2 µW (interna 40,3; chaveamento 12,9) |
| Potência dinâmica sem vetores | 122,4 µW |
| Potência de fuga | 1,21 mW |
| Potência total (SAIF) | 1,26 mW (FIR: 87%) |

Corners de timing (PrimeTime): tt0p85v25c, ss0p75v125c (0,75 V, 125 °C) e ff0p95vn40c (0,95 V, −40 °C).

### SDF da simulação pós-layout

O SDF do `write_sdf` do Fusion Compiler escreve os bits das portas de barramento com escape (`y_out\[18\]`), o que gera 19 erros `SDFCOM_PONF` no VCS, e usa resolução de 10 ps. A simulação pós-layout usa o SDF gerado pelo PrimeTime (`write_sdf -context verilog`, 1 ps).

Foi verificado que:
- não falta nenhum arco de atraso;
- o CLK→Q medido no simulador é igual ao do SDF;
- um hold propositalmente inflado é detectado.

Causa, evidências e comandos: [docs/auditoria_sdf.md](docs/auditoria_sdf.md).

### Hold no corner rápido

- O P&R otimiza somente o corner típico. Para cobrir o corner ff, o CTS e o roteamento usam incerteza de hold de 0,25 ns (`cts.tcl`, `route.tcl`); o `finish.tcl` restaura 0,10 ns.
- Um ECO de hold do PrimeTime após o roteamento foi testado e descartado: 1.353 células de atraso sem espaço livre geraram sobreposições e falhas de DRC/LVS.
- No PrimeTime, a incerteza de hold após o CTS é 0,05 ns (jitter + margem). Os 0,10 ns do SDC são a margem pré-CTS, que inclui o skew estimado, já presente no clock propagado. Com 0,10 ns, restam 148 caminhos de scan (Q → SI) com até −0,04 ns no corner ff; esses caminhos só são usados no modo de teste.
- Caminhos de E/S: com a latência de E/S medida em cada corner, restam no ff 42 caminhos da entrada `rst` com até −0,03 ns. O hold de E/S depende das hipóteses externas preliminares do SDC (atraso mínimo de entrada 0 ns) e deve ser revisto na integração do bloco.

## Ferramentas

Synopsys VCS e Verdi (simulação), Design Compiler (síntese e DFT), TestMAX ATPG, Fusion Compiler (P&R), PrimeTime (timing multi-corner) e IC Validator (DRC/LVS).
