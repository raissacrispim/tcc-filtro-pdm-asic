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

A implementação é comparada amostra por amostra com o Golden Model para dez vetores de teste:

- senoide de 10 kHz
- senoide de 30 kHz
- senoide de 50 kHz
- senoide de 80 kHz
- 50 kHz com ruído
- burst de 50 kHz com ruído
- fundo de escala: blocos de 2.400 bits alternando entre todos em 0 e todos em 1
- 50 kHz com interferência de 130 kHz (fora da banda)
- varredura de frequência de 0 a 150 kHz em 2 ms
- impulso: padrão 0101… com um único bit invertido (resposta ao impulso)

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
| Timing multi-corner (tt/ss/ff) e multimodo (funcional/scan) | PrimeTime | `sta/scripts/run_sta.sh` | raiz |
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
| ATPG pós-layout | stuck-at 98,57% (92 padrões); transition 97,27% (165 padrões, `scan_en` = 0 e entradas fixas em velocidade) |
| Simulação dos padrões ATPG (VCS, carga serial) | stuck-at e transition, sem atraso e com SDF: 0 divergências |
| DRC (IC Validator) | CLEAN (396 regras) |
| LVS (IC Validator) | comparação PASS e 0 violações de regra (inclui etiquetas de portas) |
| Core / chip | 240 × 240 µm (57.349 µm²) / 67.328 µm² |
| Área de células | 40.705 µm² (utilização do core 71,0%) |
| Células | 10.067 (sem fillers) |
| Capacitância/transição máximas | 0 violações |
| Setup (tt / ss / ff) | +60,20 / +56,80 / +61,87 ns |
| Hold, modo funcional (tt / ss / ff) | +0,1330 / +0,3570 / +0,0105 ns |
| Hold, modo scan (tt / ss / ff) | +0,1330 / +0,3570 / +0,0098 ns |
| STA (3 corners × 2 modos, incerteza de hold 0,10 ns) | 0 violações de setup e hold |
| Potência dinâmica (SAIF, sinal de 50 kHz com ruído; layout de 20/10, antes da auditoria final) | 53,4 µW (interna 41,1; chaveamento 12,3) |
| Potência dinâmica sem vetores | 36,9 µW |
| Potência de fuga | 1,24 mW |
| Potência total (SAIF) | 1,29 mW (FIR: 87,4%) |

Corners de timing (PrimeTime): tt0p85v25c, ss0p75v125c (0,75 V, 125 °C) e ff0p95vn40c (0,95 V, −40 °C).

### SDF da simulação pós-layout

O SDF do `write_sdf` do Fusion Compiler escreve os bits das portas de barramento com escape (`y_out\[18\]`), o que gera 19 erros `SDFCOM_PONF` no VCS, e usa resolução de 10 ps. A simulação pós-layout usa o SDF gerado pelo PrimeTime (`write_sdf -context verilog`, 1 ps).

Foi verificado que:
- não falta nenhum arco de atraso;
- o CLK→Q medido no simulador é igual ao do SDF;
- um hold propositalmente inflado é detectado.

Causa, evidências e comandos: [docs/auditoria_sdf.md](docs/auditoria_sdf.md).

### Timing pós-layout

Uma auditoria independente da STA encontrou erros na metodologia anterior:
- a latência de E/S era lida da coluna de transição;
- a incerteza de hold era reduzida para 0,05 ns;
- o corner rápido era aproximado no P&R.

Os resultados publicados antes dela não são válidos.

Correção:
- **E/S:** referenciadas a um clock virtual (`vclk`, clock da placa), mantido ideal no P&R.
- **P&R:** cenários MCMM (`func_tt`, `func_ff`, `scan_tt`, `scan_ff`), com a biblioteca `ff0p95vn40c` conferida pelo PVT. O `finish.tcl` corrige o hold residual dos caminhos Q → SI e a capacitância máxima por ECO.
- **Floorplan:** core ampliado de 220 para 240 µm (84% → 70% de utilização), para dar espaço às correções.
- **Signoff no PrimeTime:** usa as restrições originais (incerteza de hold de 0,10 ns), em 3 corners × 2 modos (funcional e scan), com a contagem de endpoints com 4 casas decimais.

O ECO de hold do `finish.tcl` corrige com uma margem de 10 ps, além da incerteza de 0,10 ns. No PrimeTime, o pior hold no ff ficou em +10,5 ps (funcional) e +9,8 ps (scan).

A auditoria final (portas de saída, protocolo do ATPG, simulação dos padrões e scripts) está registrada em [docs/auditoria_final.md](docs/auditoria_final.md).

Causa, diagnóstico, correção e critérios: [docs/auditoria_sta.md](docs/auditoria_sta.md).

## Ferramentas

Synopsys VCS e Verdi (simulação), Design Compiler (síntese e DFT), TestMAX ATPG, Fusion Compiler (P&R), PrimeTime (timing multi-corner) e IC Validator (DRC/LVS).
