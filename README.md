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
| Finalização e GDSII | Fusion Compiler | `fc_shell -f pnr/scripts/finish.tcl` | raiz |
| Simulação pós-layout com SDF | VCS | `sim/scripts/compile_gls.sh pnr sdf` | raiz |
| DRC e LVS | IC Validator | pendente | — |

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

Os scripts de DFT, ATPG, `place.tcl`, `cts.tcl`, `route.tcl`, `finish.tcl` e `timing_setup.tcl` são versões candidatas, ainda não validadas nas ferramentas.

## Ferramentas

A simulação e depuração RTL foram realizadas utilizando ferramentas Synopsys, incluindo VCS e Verdi.

O fluxo físico (síntese no Design Compiler e floorplan no Fusion Compiler) está em andamento em `synth/` e `pnr/`.
