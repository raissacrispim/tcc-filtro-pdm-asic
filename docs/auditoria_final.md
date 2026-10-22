# Auditoria final (commit auditado `09df172`)

Uma auditoria independente, numa cópia isolada (`~/tcc_auditoria_final`), reproduziu:
- STA sem violações em 3 corners × 2 modos;
- DRC CLEAN e LVS com comparação elétrica PASS;
- GLS 10/10;
- ATPG stuck-at 98,63% e transition 98,28%.

Ela apontou sete ressalvas. Este documento registra, para cada uma, a evidência, a causa, a decisão e a revalidação. As evidências da auditoria (`*/auditoria_independente/`) pertencem à cópia de auditoria e não foram alteradas.

## P1 — `text_net:text_short` entre `scan_out` e `y_out[18]` (LVS)

**Evidência.** O próprio repositório tem a violação desde 13/10 (`verif/reports/lvs/filtro_pdm.RESULTS`: `text_net:text_short v = 1`, com `LVS Compare Result: PASS`). O `run_lvs.sh` anterior só conferia a comparação elétrica.

**Causa.**
- Na síntese, `n732` (saída `y_out_18__BAR` do FIR, isto é, o registrador `y_out[18]` invertido) alimenta dois inversores: `U804 → scan_out` e `U805 → y_out[18]`. O DFT usou o registrador de saída do FIR como última célula da cadeia e criou a porta `scan_out` dedicada.
- Consulta aos checkpoints do FC (`init`, `power_plan_reproduzido`: drivers U805/U804; `place` em diante: `HFSINV_66_144` nas duas portas): a **high-fanout synthesis do `place_opt`** fundiu os dois inversores, que são logicamente equivalentes. A netlist passou a ter `assign y_out[18] = scan_out`, e no layout uma única rede chega a dois pinos com nomes diferentes.
- O histórico mostra que a fusão depende da execução: ocorre em `6bff893`, `f7a7123` e `0a45910`, e não em `4250979` nem em `542c853`.

**Impacto.**
- A função não muda (as duas saídas valem `NOT n732`), e por isso a comparação elétrica passa.
- Fisicamente, porém, há duas portas de saída em curto dentro do bloco: a carga externa de uma soma-se à da outra, e na integração isso liga destinos diferentes. **É um defeito real.**

**Correção.**
- `pnr/scripts/place.tcl`, antes do `place_opt`:
  - os drivers de todas as portas de saída ficam com `size_only`: podem ser redimensionados, não removidos nem fundidos;
  - `opt.port.eliminate_verilog_assign` fica ligada como segunda proteção;
  - depois do `place_opt`, o script para se duas portas de saída estiverem na mesma rede.
- `pnr/scripts/finish.tcl`: para se a netlist exportada tiver qualquer `assign`.
- `verif/scripts/run_lvs.sh`: aprova só com a comparação PASS **e** 0 violações de regra no `.RESULTS`.

## P2 — Folga de hold de +0,153 ps no ff (modo scan)

**Evidência.**
- O caminho `int3_reg_9/Q → int2_reg_10/SI` é uma ligação direta da cadeia de scan.
- A folga já desconta a incerteza de hold de 0,10 ns.
- Histograma no PrimeTime, corner ff (`~/diag_auditoria/p2_hist.txt`):

  | Folga abaixo de | Funcional | Scan (em SI) |
  |---|---|---|
  | 5 ps | 12 | 64 (48) |
  | 10 ps | 29 | 219 (144) |
  | 20 ps | 478 | 696 (166) |
  | 50 ps | 1.282 | 1.630 (179) |

**Causa.** O ECO de hold do `finish.tcl` corrigia só folgas negativas, pela análise do FC. O signoff é feito no PrimeTime, com outra extração. Folgas de fração de picossegundo dependem da correlação entre as ferramentas, não de uma margem real.

**Decisão.** O circuito já atende à especificação, mas a margem é frágil. O ECO passa a tratar como violado todo pino com **folga de hold abaixo de 10 ps** (`HOLD_MARGEM`). A restrição fica mais exigente, não mais frouxa. O custo estimado é de cerca de 250 buffers pequenos (cerca de 1% da área de células). A folga de setup (≥ 56 ns funcional, cerca de 187 ns shift) absorve o atraso. 20 ps custaria cerca de 1.100 células, sem necessidade.

## P3 — Aviso M487 (`scan_en` sem restrição no ATPG transition)

**Evidência.** O SPF faz `scan_en = 1` apenas no procedimento de shift. Os scripts não tinham `add_pi_constraints` nem `set_delay -nopi_changes`.

**Causa.** Nos ciclos de lançamento e captura (launch-on-capture), o TestMAX podia variar o `scan_en` e as demais entradas. No testador, o `scan_en` é um sinal global lento, fixo em 0 entre o fim do shift e a captura. Os padrões que dependem dessa variação não são realizáveis em velocidade. **É um defeito real do protocolo.**

**Correção** (`atpg/scripts/atpg_transition.tcl`):
- `add_pi_constraints 0 scan_en`;
- `set_delay -nopi_changes` e `set_delay -nopo_measures`.

Os padrões transition precisam ser regerados; a cobertura que sair dessa nova geração é a válida. No stuck-at (teste lento), o `scan_en` continua livre na captura, como escolha documentada no script.

## P4 — Avisos de modelagem do ATPG

Instâncias identificadas (`~/diag_auditoria/atpg_*.txt`):

| Regra | Origem | Avaliação |
|---|---|---|
| N20 (2) | `saed32nm.v` linhas 6647 e 6746: tabela UDP sem a combinação `00t` (biblioteca do PDK) | Inerente à biblioteca; não foi alterada. O efeito prático é medido na simulação dos padrões (P5). |
| B7 (3), B8 (2) | Portas de DFT de `u_fir` (`dftopt1/3/6`, `test_si`, `dftopt4`) que ficaram sem uso após a reordenação da cadeia no placement | Hierarquia sem função; não afeta a cadeia, que foi rastreada com 1.332 células. |
| B9 (2) | `SYNOPSYS_UNCONNECTED_79/82` | Redes sem driver geradas pela síntese para saídas não usadas. |
| B10 (191) | Redes internas dos modelos Verilog das células (ex.: `SDFFX1_RVT/CLK_D`), usadas só nas verificações de timing | Inerentes à biblioteca. |

Os scripts de ATPG passaram a gravar `report_violations -all` em `atpg/reports[/pnr]/`.

## P5 — Simulação dos padrões do ATPG

**Evidência.** O `sim/scripts/sim_atpg.sh` existia, mas só aceitava a netlist da síntese, e não havia nenhum log de execução. O transition não tinha testbench.

**Correção.**
- O `sim_atpg.sh` passou a aceitar `<synth|pnr> <stuck|transition> <zero|sdf>`.
- Todos os padrões são carregados **em série** pela porta `scan_in`, exercitando a cadeia inteira.
- Critério de aprovação: `completed with 0 mismatches` e nenhuma violação de timing.
- O `atpg_transition.tcl` passou a gerar o testbench.
- A simulação com SDF usa o período do STIL (100 ns): comprova os padrões com os atrasos reais nessa frequência, mas não é um teste em velocidade de um circuito rápido.

## P6 — Restrições do SDC

Os valores não foram alterados. O cabeçalho de `pnr/constraints/filtro_pdm_physical.sdc` classifica cada valor:
- **requisito:** período de 208,333 ns (4,8 MHz);
- **datasheet:** `pdm_in`, 18–40 ns após a borda de descida;
- **hipótese de integração:**
  - incertezas de 1,0 ns (setup) e 0,10 ns (hold);
  - atrasos de E/S de 0–20 ns;
  - carga de 2 fF;
  - entradas dirigidas por `NBUFFX8`;
  - `vclk` sem skew de placa;
  - clock de shift igual ao funcional.

A coerência com os requisitos foi conferida: o `pdm_in`, lançado na descida e capturado na subida, explica a folga de setup de cerca de 60 ns; a saída de 300 kHz está no mesmo domínio de clock.

## P7 — Robustez dos scripts

- `set -o pipefail` em `run_atpg.sh`, `run_drc.sh`, `run_lvs.sh` e `sim_atpg.sh`. Antes, o código de saída de `ferramenta | tee` era o do `tee`.
- `run_atpg.sh`: reprova se o log tiver `Error:`, se o script do TestMAX não chegar ao fim ou se o resumo não existir.
- `run_drc.sh`: reprova se houver violações.
- `run_lvs.sh`: reprova pelas violações de regra, como descrito em P1.
- Retirados os comentários "Versão candidata, ainda não validada" dos scripts de P&R, DRC, LVS e ATPG.

## Revalidação

*(a preencher com os resultados da nova execução)*
