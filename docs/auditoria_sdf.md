# Auditoria da anotação SDF na simulação pós-layout

## Sintoma

A compilação da simulação gate-level pós-layout com o SDF exportado pelo Fusion Compiler (`write_sdf` em `pnr/scripts/finish.tcl`) gerava:

```
Error-[SDFCOM_PONF] Port \y_out[18] ... INTERCONNECT does not exist
...
Total errors: 19
Total warnings: 2      (SDFCOM_UHICD em valid_out e scan_out)
```

A regressão passava (10/10). Por isso era preciso verificar se a anotação estava de fato correta, e não apenas se a simulação terminava.

## Causa raiz

Em SDF, `y_out\[18\]` (colchetes escapados) é um **identificador escalar** cujo nome contém colchetes. Já `y_out[18]` é o **bit 18 do barramento** `y_out`. A netlist declara `output [18:0] y_out;`. Para o VCS, `\y_out[18]` é uma porta inexistente, e a interconexão correspondente não é anotada.

Verificação da causa:

1. **Arquivo:** o SDF do FC contém exatamente 19 nomes escapados, `y_out\[0\]` … `y_out\[18\]`, todos em `INTERCONNECT` para portas de saída. São os mesmos 19 dos erros. Não há nenhum outro erro de anotação.
2. **Ferramentas:** o `write_sdf` do Fusion Compiler não tem opção que controle o escape. As opções disponíveis são apenas `-significant_digits` e a inclusão ou exclusão de grupos. No PrimeTime, `write_sdf -context verilog` escreve os bits de barramento sem escape. O contexto padrão escapa os colchetes, como o FC.
3. **Reprodução mínima** (netlist de 2 células, VCS):
   - Com o SDF escapado: 2 erros PONF, e o atraso de interconexão da porta é **perdido**.
   - Com o mesmo SDF usando bit de barramento: 0 erros, e o atraso é **aplicado**.
   - O aviso SDFCOM_UHICD não perde o atraso: o VCS o aplica na saída do driver.

Impacto no projeto: no SDF do FC, todas as 21 interconexões para portas de saída valem 0,00 ns. Os erros não alteravam a simulação, e isso explica os 10/10. O problema atingia apenas essas interconexões.

### Problema adicional: resolução

O FC grava os atrasos com 2 casas decimais (10 ps). Com isso, 24.705 das 24.911 interconexões são escritas como 0,00, e as verificações de setup e hold ficam quantizadas em 10 ps.

## Correção

O SDF da simulação passa a ser gerado pelo PrimeTime, a partir dos mesmos dados do signoff. O SDF do FC não é editado e continua sendo exportado para comparação.

| Item | Valor |
|---|---|
| Script | `sta/scripts/write_sdf_gls.tcl` (chamado por `sta/scripts/run_sdf_gls.sh`) |
| Netlist | `pnr/output/filtro_pdm_pnr.v` |
| Parasitas | `pnr/output/filtro_pdm.Cmax_25.spef` (RC) |
| Restrições | `pnr/output/filtro_pdm_pnr.sdc` |
| Corner | tt0p85v25c (o mesmo do SDF do FC) |
| Comando | `write_sdf -version 3.0 -context verilog -significant_digits 3 -include {SETUPHOLD RECREM} -input_port_nets` |
| Saída | `pnr/output/filtro_pdm_pnr_pt.sdf` |

- `-context verilog`: bits de barramento como `y_out[18]`.
- `-significant_digits 3`: resolução de 1 ps.
- `SETUPHOLD`/`RECREM`: correspondem às verificações `$setuphold`/`$recrem` dos modelos Verilog da SAED32.
- Interconexões das portas de saída: não são escritas, que é o padrão do PrimeTime. O maior desses atrasos é 0,004 ns. Quando incluídas (`SDF_SAIDAS=1`), o VCS emite 21 SDFCOM_UHICD e aplica o atraso na saída do driver. Os dois SDFs foram testados.

O clock dos registradores é propagado: o SDC do FC aplica `set_propagated_clock` na porta `clk`. O aviso UITE-305 do PrimeTime vem do `set_clock_latency` de E/S, que torna ideal apenas o objeto clock, e não altera os atrasos de célula do SDF. O caminho do clock no `report_timing -path_type full_clock_expanded` passa pelas células reais da árvore (0,119 ns até o pino CLK).

## Evidências

### Parasitas (PrimeTime)

- Todas as 13.844 redes pino a pino estão anotadas com rede RC.
- As 220 redes não anotadas são 44 sem driver e 176 sem carga (`SYNOPSYS_UNCONNECTED_*`, saídas não usadas).

### Conteúdo dos SDFs

| | SDF do FC | SDF do PT | PT + portas de saída |
|---|---|---|---|
| Linhas IOPATH | 73.009 | 38.490 | 38.490 |
| Arcos IOPATH únicos (pino→pino) | 30.314 | 30.314 | 30.314 |
| Verificações | SETUP 7.992 / HOLD 7.992 | SETUPHOLD 7.992, WIDTH 2.664 | idem |
| INTERCONNECT (não nulos) | 24.911 (206) | 24.890 (4.768) | 24.911 (4.782) |
| Para portas de saída (máx.) | 21 (0,00 ns) | 0 | 21 (0,004 ns) |
| Casas decimais | 2 | 3 | 3 |
| Nomes escapados | 19 | 0 | 0 |

A diferença de linhas IOPATH não é perda de arcos:
- o FC escreve cada arco duas vezes (18.266 linhas idênticas);
- nas saídas não unate, o FC escreve três variantes (`A S`, `(posedge A) S`, `(negedge A) S`).

Comparação arco a arco (`sim/auditoria_sdf/compara_sdf.py`):

```
arcos so em A (FC): 0   so em B (PT): 0
todos os arcos      : n=30314  dif PT-FC min=-6,0 mediana=0,0 max=6,0 ps
CLK->Q (flip-flops) : n=2664   dif PT-FC min=-5,0 mediana=0,0 max=6,0 ps
células CTS         : n=33     dif PT-FC min=-6,0 mediana=1,0 max=6,0 ps
```

Todas as diferenças estão dentro do arredondamento de 10 ps do FC.

### Anotação no VCS (diretório isolado)

| SDF | Erros | Avisos |
|---|---|---|
| FC | 19 SDFCOM_PONF | 2 SDFCOM_UHICD |
| PT | **0** | **0** |
| PT + portas de saída | 0 | 21 SDFCOM_UHICD, 1 SDFCOM_IWSBA |

### Atrasos aplicados (medidos no simulador)

O monitor `sim/auditoria_sdf/mede_clkq.sv` mede o flip-flop `u_cic_u_integradores_int3_reg_0_`:

| | Porta clk → pino CLK | CLK→Q (subida / descida) |
|---|---|---|
| SDF do PT (IOPATH min::max) | soma da árvore de clock | (0,151::0,157) / (0,154::0,161) |
| PrimeTime (`report_timing`) | 0,119 ns | 0,161 ns |
| Simulação com SDF do PT | 0,120 ns | 0,157 / 0,161 ns |
| Simulação sem SDF (controle) | 0,017 ns | 0,185 / 0,207 ns |

- O CLK→Q medido é igual ao valor máximo do SDF (o VCS usa `-sdf max`).
- O atraso de clock corresponde à soma dos atrasos da árvore no SDF, cada um com 1 ps de resolução.
- Sem o SDF, os valores são os padrões do modelo da biblioteca.

### Verificações temporais ativas (controle negativo)

`sim/auditoria_sdf/hold_inflado.py` cria uma cópia do SDF do PT em que o hold de D desse mesmo flip-flop passa de −0,056 ns para 50 ns. Resultado com essa cópia:
- 4 `Timing violation ... $setuphold` (saed32nm.v, linhas 20890, 20899, 20900);
- `Q = x`;
- teste reprovado, com 600 erros.

Com o SDF correto: 0 violações e teste aprovado. Isso mostra que as verificações de setup/hold do SDF estão ativas e que a ausência de violações na regressão é um resultado real.

### Regressão

- 10/10 testes aprovados com o SDF do PT, sem nenhuma `Timing violation`.
- As 10 saídas `*_output_rtl.txt` são idênticas (`cmp`) às da execução anterior, que foi preservada antes da auditoria em `~/evidencias_sdf_20261016_1448` com `SHA256SUMS`.

### Execução pelo fluxo do repositório

Os comandos `sta/scripts/run_sdf_gls.sh`, `sim/scripts/compile_gls.sh pnr sdf` e `sim/scripts/run_gls_regression.sh` foram executados na raiz do repositório:

- **Anotação:** `Total errors: 0`, `Total warnings: 0`.
- **Regressão:** 10/10 aprovados, e as 10 saídas são idênticas às preservadas.
- **Ordem dos blocos:** o PrimeTime não escreve os blocos `CELL` sempre na mesma ordem, por isso o `diff` linha a linha contra o SDF validado mostra apenas blocos trocados de posição. A igualdade de conteúdo é verificada com `sim/auditoria_sdf/mesmo_conteudo_sdf.py`, que compara os blocos independentemente da ordem e o cabeçalho sem a data.

### Variante com portas de saída (`SDF_SAIDAS=1`)

- **21 SDFCOM_UHICD:** um por porta de saída. O VCS aplica o atraso na saída da célula que dirige a porta; isso foi comprovado na reprodução mínima.
- **1 SDFCOM_IWSBA:** ocorre na interconexão `copt_h_inst_2391.Y → y_out`. Na netlist, essa célula dirige `scan_out`, e `y_out[18]` é ligado a ela por `assign y_out[18] = scan_out;`. O VCS informa que a interconexão "will still be annotated" (ainda será anotada).
- **Por que essa variante não é a padrão:** os dois avisos se referem a atrasos de no máximo 0,004 ns. Para manter a anotação sem avisos, ela não é usada por padrão.

## Como reproduzir

Fluxo (a partir da raiz, após `finish.tcl`):

```bash
sta/scripts/run_sdf_gls.sh          # gera pnr/output/filtro_pdm_pnr_pt.sdf
sim/scripts/compile_gls.sh pnr sdf  # 0 erros / 0 avisos de anotação
sim/scripts/run_gls_regression.sh
sim/scripts/compile_gls.sh pnr sdf_fc   # SDF do FC, só para comparação (19 PONF)
```

Auditoria em diretório isolado:

```bash
R=~/sdf_teste; mkdir -p $R/netlist
cp -r tb vectors $R/; cp pnr/output/filtro_pdm_pnr.v $R/netlist/
rm -f $R/vectors/*_output_rtl.txt
A=sim/auditoria_sdf
python3 $A/compara_sdf.py pnr/output/filtro_pdm_pnr.sdf pnr/output/filtro_pdm_pnr_pt.sdf
python3 $A/mesmo_conteudo_sdf.py pnr/output/filtro_pdm_pnr_pt.sdf outro.sdf   # mesmo conteúdo?
python3 $A/hold_inflado.py pnr/output/filtro_pdm_pnr_pt.sdf $R/neg.sdf u_cic_u_integradores_int3_reg_0_
$A/compila_teste.sh sim_fc  pnr/output/filtro_pdm_pnr.sdf
$A/compila_teste.sh sim_pt  pnr/output/filtro_pdm_pnr_pt.sdf
$A/compila_teste.sh sim_sem nenhum
$A/compila_teste.sh sim_neg $R/neg.sdf
(cd $R/sim_pt && ./simv +TEST=test_01_10k | grep -E 'MEDE|Timing violation|APROVADO|REPROVADO')
```
