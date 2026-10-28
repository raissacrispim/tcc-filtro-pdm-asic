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

- `rtl/`: módulos SystemVerilog sintetizáveis. A síntese usa os arquivos listados em `synth/scripts/synth.tcl`. `rtl/fir_antes_sintese.sv` é uma versão histórica do FIR, que declara o mesmo módulo `fir` e não deve ser compilada junto com `rtl/fir.sv`.
- `tb/`: testbenches de verificação
- `golden_model/`: Golden Model em Python
  - `golden_model.py`: modelo oficial e geração dos vetores (`python3 golden_model/golden_model.py`)
  - `analise_desempenho.py`: métricas de desempenho a partir das saídas do hardware (`docs/desempenho_filtro.md`)
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

Os vetores esperados (`*_golden.txt`) são gerados pelo Golden Model com o CIC de 18 bits. As saídas `*_output_rtl.txt` versionadas são as da última regressão pós-layout com SDF, idênticas às da simulação RTL.

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
| Simulação RTL x Golden Model | 10/10 testes; CIC, FIR e filtro completo: 6.000 amostras cada, 0 divergências (auditoria independente de 27/10) |
| Simulação gate-level pós-síntese (sem atrasos) | 10/10 testes; saídas idênticas às de referência |
| Simulação pós-layout com SDF (PrimeTime) | 10/10 testes aprovados; anotação sem erros ou avisos; 0 violações de timing |
| DFT | 1 cadeia de scan, 1.332 flip-flops |
| ATPG pós-layout | stuck-at 98,57% (92 padrões); transition 97,27% (165 padrões, `scan_en` = 0 e entradas fixas entre lançamento e captura) |
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
| Potência dinâmica (SAIF, sinal de 50 kHz com ruído) | 53,4 µW (interna 41,0; chaveamento 12,4) |
| Potência dinâmica sem vetores | 36,9 µW |
| Potência de fuga | 1,26 mW |
| Potência total (SAIF) | 1,31 mW (FIR: 86,7%) |

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

A versão congelada para o TCC e o registro no INPI (tag `v1.0-tcc`), com os hashes SHA-256 do GDSII, das netlists, do SDF, do SPEF e dos coeficientes, está em [docs/congelamento_v1.0.md](docs/congelamento_v1.0.md).

Imagens do layout e das simulações, geradas pelo Fusion Compiler e pelo Verdi a partir da versão congelada: galeria comentada em [docs/imagens.md](docs/imagens.md); roteiro e scripts em [imagens/ROTEIRO.md](imagens/ROTEIRO.md).

Causa, diagnóstico, correção e critérios: [docs/auditoria_sta.md](docs/auditoria_sta.md).

## Escopo e limitações da verificação

Os resultados acima valem nas condições descritas. Eles **não** comprovam:
- **Operação em silício.** O chip não foi fabricado nem caracterizado.
- **Equivalência formal (LEC) entre RTL, síntese e layout.** A equivalência é sustentada por simulação (RTL, GLS pós-síntese e GLS pós-layout com SDF, mesmas saídas) e pela comparação das netlists PNR e LVS, não por uma ferramenta formal.
- **Teste em velocidade (at-speed).** Os padrões ATPG foram simulados com período de 100 ns (STIL) e com o SDF do PrimeTime, sem divergências. Isso não equivale a um teste em velocidade de um circuito rápido.
- **Timing em toda condição.** A STA cobre 3 corners (tt0p85v25c, ss0p75v125c, ff0p95vn40c) × 2 modos (funcional e scan). O P&R otimizou 4 cenários (tt e ff × funcional e scan); o ss só é verificado.

Hipóteses e valores a registrar:
- **Interface:** atrasos de E/S de 0–20 ns, carga de 2 fF, entradas dirigidas por `NBUFFX8_RVT`, `vclk` sem skew de placa e clock de shift igual ao funcional. A porta `clk` não tem driving cell (aviso do `check_timing`). O único valor de datasheet é o `pdm_in` (SPH0641, 18–40 ns). Origem de cada valor: cabeçalho de `pnr/constraints/filtro_pdm_physical.sdc`.
- **Hold:** o pior caso é +9,771 ps (ff, modo scan, `delay_reg_41__9_/QN → delay_reg_39__8_/SI`), além dos 0,10 ns de incerteza do SDC. É positivo, mas é a menor margem do projeto.
- **SDF:** a simulação usa o SDF do PrimeTime. O do Fusion Compiler escapa bits de barramento e gera erros de anotação no VCS (`docs/auditoria_sdf.md`).
  - No layout atual, os dois SDFs têm os mesmos 30.475 arcos de célula, sem nenhum arco só em um deles. Em 30.471 arcos, a diferença está dentro do arredondamento de 10 ps do SDF do FC; em 4, chega a −14 ps.
  - A anotação no VCS tem 0 erros e 0 avisos.
  - O que foi comparado é a presença dos arcos nos dois arquivos, não a anotação de cada arco pelo simulador.
- **ATPG:** a cobertura não é de 100% (stuck-at 98,57%; transition 97,27%). Avisos remanescentes, explicados em `docs/auditoria_final.md`: N20 (biblioteca), B7–B10 (portas de DFT e redes sem uso) e M977 (opção `-nopi_changes` mantida de propósito).
- **Potência:** estimativa por SAIF, de um único estímulo (50 kHz com ruído).
- **Fluxo:** o fluxo executado é inteiramente Synopsys (VCS, Design Compiler, Fusion Compiler, PrimeTime, TestMAX ATPG, IC Validator). Nenhuma etapa foi feita com ferramentas Cadence.

## Ferramentas

Synopsys VCS e Verdi (simulação), Design Compiler (síntese e DFT), TestMAX ATPG, Fusion Compiler (P&R), PrimeTime (timing multi-corner) e IC Validator (DRC/LVS).
