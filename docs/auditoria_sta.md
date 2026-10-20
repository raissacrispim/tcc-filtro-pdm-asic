# Auditoria da STA pós-layout

## Origem

Uma auditoria independente da STA pós-layout (PrimeTime X-2025.06-SP2) apontou quatro problemas:

- **A** — erros no script `sta/scripts/sta_corner.tcl`;
- **B** — violações de hold no corner ff;
- **C** — violações na cadeia de scan;
- **D** — violações de hold nas saídas.

Este documento registra a causa de cada um, o diagnóstico, a correção e o critério de aprovação.

## Causas

### A — Latência de E/S calculada errada

O proc `latencias_clock` da versão anterior do `sta_corner.tcl` tinha dois defeitos:

1. `report_clock_timing -type latency` com `-early`/`-late` falha nesta versão (CMD-010). O `catch` escondia o erro e repetia o relatório sem a opção.
2. A expressão regular capturava o primeiro número após `/CLK`, que é a coluna `Trans`. O relatório tem as colunas `Trans | Source | Network | Total`.

Valores aplicados como latência de E/S, comparados com a latência real dos registradores:

| Corner | Aplicado (transição) | Latência real dos registradores |
|---|---|---|
| tt | 0,040 / 0,063 ns | 0,081 – 0,136 ns |
| ss | 0,061 / 0,115 ns | 0,115 – 0,205 ns |
| ff | 0,027 / 0,040 ns | 0,053 – 0,083 ns |

### Incerteza de hold reduzida

A versão anterior trocava a incerteza de hold do SDC (0,10 ns) por 0,05 ns. A justificativa era que o valor pré-CTS incluiria o skew estimado. Porém, o valor foi escolhido depois de conhecidas as violações e sem um orçamento documentado de jitter e margem. **O signoff passa a usar 0,10 ns do SDC, sem alteração.**

### B e C — Corner ff não otimizado

O P&R tinha um único cenário, no corner tt. O corner ff era aproximado aumentando a incerteza de hold para 0,25 ns no CTS e no roteamento. Isso não reproduz o ff, porque atrasos e tempos de hold da biblioteca variam em proporções diferentes. Os caminhos de deslocamento da cadeia (Q/QN → SI) ligam flip-flops vizinhos sem lógica entre eles e ficaram até 37 ps abaixo do hold exigido. O hold não depende da frequência, então um shift lento não resolve: no silício a cadeia seria corrompida.

### D — Referência temporal das E/S

O SDC exportado pelo FC contém `set_clock_latency -min 0.234568 / -max 0.265257` (`-origin useful_skew`). É uma estimativa do corner típico, maior até que a latência real dos registradores no tt. No ff, o dado sai com a latência real (≤ 0,083 ns), mas o receptor externo era modelado como se recebesse o clock 0,235 ns depois. Por isso as 21 saídas violavam em até −0,117 ns. Em outras referências fisicamente justificáveis, as saídas passam (tabela abaixo).

## Diagnóstico (layout anterior, incerteza de hold 0,10 ns)

O script `sta/diagnostico/run_diagnostico.sh` (somente leitura) analisa:
- 3 corners;
- 3 modos: `func` (scan_en = 0), `shift` (scan_en = 1) e `todos` (sem case analysis);
- 3 referências de E/S: `porta` (clock na porta, latência 0), `real` (latência real dos registradores) e `fc` (latência do SDC do FC).

Resultado completo: `sta/diagnostico/reports/resumo.txt`.

Referência `porta`, modo `todos`:

| Classe | tt | ss | ff |
|---|---|---|---|
| reg→reg funcional (D) | 0 | 0 | 0 |
| reg→reg shift (Q → SI) | 0 | 0 | 148, WNS −0,037 |
| `rst` → reg | 26, −0,049 | 0 | 294, −0,104 |
| `scan_en` → SE | 16, −0,029 | 0 | 895, −0,088 |
| `scan_in` → SI | 0 | 0 | 1, −0,074 |
| Folga de hold das saídas | +0,425 | +0,950 | +0,148 |
| Setup | +60,2 | +56,7 | +61,9 |

Com a referência `fc`, as saídas do ff violam (21, −0,117) e as entradas passam. Esse é o resultado da auditoria independente.

O que o diagnóstico mostra:

- A lógica funcional não tem violação de hold entre registradores em nenhum corner.
- As saídas passam com o clock externo na porta.
- As violações reais estão nas entradas `rst`/`scan_en`/`scan_in` e nos 148 caminhos Q → SI.

## Correção

### Restrições (`pnr/constraints/`)

- **Clock virtual `vclk`:** o clock da placa, ideal e sem latência. Todas as restrições de E/S passam a ser referenciadas a ele, inclusive as portas de scan. A premissa é que os circuitos externos (microfone, receptor e testador) recebem o clock da placa, como na porta `clk`. Os atrasos mínimos de E/S permanecem 0 ns, o pior caso.
- **Incerteza nos caminhos de E/S:** as mesmas margens, explícitas entre `vclk` e `clk` (setup 1,0 ns; hold 0,10 ns).
- **`set_driving_cell NBUFFX8_RVT`** nas entradas de dados, no lugar de `set_input_transition`.

Com o clock virtual, o FC não gera latência de E/S. O P&R e o PrimeTime passam a usar a mesma premissa.

### Implementação física (Fusion Compiler)

`pnr/scripts/timing_setup.tcl` cria quatro cenários (MCMM):

| Cenário | Modo | Corner | Análise |
|---|---|---|---|
| `func_tt` | scan_en = 0 | tt0p85v25c (Cmin/Cmax) | setup, hold, DRV, potência |
| `func_ff` | scan_en = 0 | ff0p95vn40c (Cmin) | hold |
| `scan_tt` | sem case analysis | tt | hold |
| `scan_ff` | sem case analysis | ff | hold |

- O `clock_opt` e o `route_opt` corrigem o hold de cada cenário com a incerteza do SDC.
- O aumento artificial para 0,25 ns foi removido de `cts.tcl` e `route.tcl`, e a restauração de 0,10 ns foi removida de `finish.tcl`.
- O script para com erro se o corner ff não usar a biblioteca `ff0p95vn40c`.

### Metodologia (PrimeTime)

`sta/scripts/sta_corner.tcl`:
- usa as restrições originais (`pnr/constraints/`) com `set_propagated_clock [get_clocks clk]`;
- não altera nenhuma margem nem latência;
- analisa os modos `func` e `scan` nos três corners;
- conta os endpoints violados por classe, com 4 casas decimais.

O proc de latência foi removido.

### Ajustes após a primeira execução do fluxo corrigido

1. **Corner ff na NDM:** a biblioteca `ff0p95vn40c` tem `nom_process : 1.01` (tt: 1.00). Com 1.0, o FC escolhia o pane `tt0p85vn40c` (aviso PVT-030). O `timing_setup.tcl` passou a usar 1.01, e o fluxo para se o `report_pvt` não trouxer `Corner <c>: no PVT mismatches` (PVT-032) para tt e ff.
2. **Latência no clock virtual:** durante o CTS, o FC atribuiu ao `vclk` uma latência de *useful skew* (`set_clock_latency 0.112478 [get_clocks {vclk}]`, `-origin useful_skew`). Com ela, o FC via as entradas 0,11 ns mais tarde e não corrigia o hold de `rst`/`scan_en`. O PrimeTime, com latência 0 conforme o SDC original, acusava 356 + 579 endpoints no ff. `pnr/scripts/vclk_ideal.tcl` desliga o ajuste (`ccd.adjust_io_clock_latency false`) e remove a latência em todos os cenários depois de `clock_opt` e de cada `route_opt`. O `finish.tcl` confere que o SDC exportado não tem latência no `vclk`.
3. **Caminhos Q → SI:** o `route_opt` deixou cerca de 59 caminhos com −0,04 ns no `scan_ff`, ligados direto ao SI. O `finish.tcl` faz um ECO de hold, inserindo um buffer só no pino violado.
   - A primeira versão usava DELLN1X2, cuja capacitância de entrada sobrecarregou as saídas QN (até 20,6 fF para um limite de 8 fF; 50 violações de max cap).
   - A versão atual usa NBUFFX2 em série, se necessário, alternando com o ECO de capacitância máxima até os dois zerarem.

4. **Espaço físico:** mesmo com o buffer colocado junto do driver, cerca de 16 redes continuavam acima da capacitância máxima. Exemplos:
   - o buffer de `delay_49__4_` foi legalizado a cerca de 100 µm do flip-flop;
   - o somador `intadd_34_U16` ficou a cerca de 120 µm dos flip-flops `delay_reg_13__2_` e `delay_reg_49__2_`.

   Com 84% de utilização, não havia espaço livre perto dos drivers. O `route_opt` limita o deslocamento de células a 3 linhas. Os ECOs nessa região também geraram 2 violações de DRC `M1.S.1`. Por isso, o core passou de 220,4 × 217,4 µm para 240 × 240 µm, com cerca de 70% de utilização.

## Critério de aprovação

`sta/scripts/run_sta.sh` deve terminar com:

```
STA APROVADA: 0 violacoes de setup e hold em 3 corners x 2 modos
```

Além disso:
- DRC CLEAN, LVS PASS, max cap/trans 0;
- GLS 10/10 com saídas idênticas às de referência;
- ATPG com cobertura igual ou maior que a anterior.

## Reprodução

```bash
fc_shell -f pnr/scripts/setup.tcl
fc_shell -f pnr/scripts/floorplan.tcl
fc_shell -f pnr/scripts/power_plan.tcl
fc_shell -f pnr/scripts/place.tcl
fc_shell -f pnr/scripts/cts.tcl
fc_shell -f pnr/scripts/route.tcl
fc_shell -f pnr/scripts/finish.tcl
verif/scripts/run_drc.sh && verif/scripts/run_lvs.sh
sta/scripts/run_sta.sh
sta/scripts/run_sdf_gls.sh && sim/scripts/compile_gls.sh pnr sdf && sim/scripts/run_gls_regression.sh
```

## Resultados após a correção

Execução de 20/10/2026: core de 240 × 240 µm e fluxo completo (`setup` → `finish`).

| Verificação | Antes da auditoria | Depois da correção |
|---|---|---|
| Incerteza de hold no signoff | 0,05 ns (reduzida) | 0,10 ns (SDC) |
| Modos analisados | 1 (sem case analysis) | funcional e scan |
| STA, endpoints com hold violado (ff) | 169 (auditoria) | **0** |
| STA, endpoints com setup violado | 0 | **0** |
| Setup (tt / ss / ff) | +60,1 / +56,6 / +61,8 ns | +60,21 / +56,83 / +61,88 ns |
| Hold funcional (tt / ss / ff) | — | +0,1402 / +0,3938 / +0,0005 ns |
| Hold scan (tt / ss / ff) | — | +0,1269 / +0,3627 / +0,0002 ns |
| Capacitância máxima (FC) | 0 | 0 |
| DRC (IC Validator) | CLEAN | 0 violações |
| LVS | PASS | PASS |
| GLS pós-layout com SDF | 10/10 | 10/10, saídas idênticas às de referência |
| ATPG stuck-at / transition | 98,56% / 97,87% | 98,63% / 98,28% |
| Utilização do core | 84% (220 × 217 µm) | 70,3% (240 × 240 µm) |
| Células (sem fillers) | 9.932 | 9.892 |
| Potência total (SAIF) | 1,26 mW | 1,29 mW (dinâmica 53,4 µW; fuga 1,24 mW) |

As folgas de hold no ff são pequenas, mas positivas, e já descontam a incerteza de hold de 0,10 ns, que inclui jitter e margem de projeto. Não foi acrescentada margem extra no P&R.

O `check_routes` do Fusion Compiler acusa DRCs de roteamento que o IC Validator, ferramenta de signoff, não confirma (0 violações).
