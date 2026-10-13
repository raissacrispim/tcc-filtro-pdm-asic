set sh_continue_on_error false

# ============================================================
# finish.tcl
# Finalizacao, relatorios finais e exportacao
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# Tecnologia: SAED32 RVT
#
# Entrada:  filtro_pdm/route
# Saida:    filtro_pdm/finish
#           pnr/output/ (GDSII, netlists, SDF, SPEF, DEF)
#
# ATENCAO:
# Versao candidata, ainda nao validada no Fusion Compiler.
# ============================================================

# Layout (GDS) das standard cells RVT
set STDCELL_GDS \
    /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/gds/saed32nm_rvt_oa.gds

# A numeracao GDS das camadas vem do arquivo de tecnologia.
# O saed32nm_1p9m_gdsout.map esta no formato do Milkyway e
# nao e aceito pelo write_gds do Fusion Compiler (GDS-017).

file mkdir pnr/reports/finish
file mkdir pnr/output

# ------------------------------------------------------------
# 1. Abrir o checkpoint do roteamento
# ------------------------------------------------------------

open_lib pnr/work/filtro_pdm.dlib
open_block filtro_pdm/route


# ------------------------------------------------------------
# 1b. Correcao das violacoes residuais de capacitancia maxima
#
# Apos o route_opt restaram ~11 redes ate 0,10 fF acima do
# limite da biblioteca (8 ou 16 fF). A correcao e um ECO:
# a celula que dirige cada rede violada e trocada pela versao
# de maior drive (ex.: INVX1 -> INVX2), que admite maior
# carga. Em seguida a posicao e legalizada e as ligacoes sao
# refeitas com route_eco. Repete ate 3 vezes, pois a celula
# maior aumenta um pouco a carga da rede anterior.
# ------------------------------------------------------------

# Mesmas restricoes de roteamento de route.tcl (M2-M8, sem M1)
set_ignored_layers -min_routing_layer M2 -max_routing_layer M8
foreach {opcao valor} {
    route.common.global_min_layer_mode hard
    route.common.net_min_layer_mode    hard
} {
    catch {set_app_options -name $opcao -value $valor}
}

# Proximo tamanho existente da celula (INVX1_RVT -> INVX2_RVT)
proc maior_drive {ref} {
    if {![regexp {^(.*X)([0-9]+)(_RVT)$} $ref -> base n suf]} {
        return ""
    }
    foreach m {1 2 4 8 16 32} {
        if {$m <= $n} { continue }
        set lc [get_lib_cells -quiet */${base}${m}${suf}]
        if {[sizeof_collection $lc] > 0} { return $lc }
    }
    return ""
}

# Posiciona as celulas alteradas/inseridas e refaz as ligacoes
proc posiciona_e_roteia_eco {} {
    if {[catch {place_eco_cells -eco_changed_cells -legalize_only} msg]} {
        puts "Aviso: place_eco_cells ($msg)"
        if {[catch {legalize_placement -incremental} msg]} {
            puts "Aviso: legalize_placement -incremental ($msg)"
            legalize_placement
        }
    }
    route_eco
    connect_pg_net -automatic
}

# Pinos que dirigem redes com capacitancia maxima violada
proc pinos_max_cap {arquivo} {
    report_constraints -all_violators -max_capacitance > $arquivo
    set pinos {}
    set f [open $arquivo r]
    while {[gets $f linha] >= 0} {
        if {[regexp {PIN\s*:\s*(\S+)} $linha -> pino]} {
            lappend pinos $pino
        }
    }
    close $f
    return [lsort -unique $pinos]
}


for {set rodada 1} {$rodada <= 3} {incr rodada} {

    set pinos [pinos_max_cap \
        pnr/reports/finish/max_cap_antes_eco_$rodada.rpt]

    puts "ECO max cap, rodada $rodada: [llength $pinos] violacoes"
    if {[llength $pinos] == 0} { break }

    set trocadas {}
    foreach pino $pinos {
        set celula [get_cells -quiet -of_objects [get_pins -quiet $pino]]
        if {[sizeof_collection $celula] == 0} { continue }
        set ref  [get_attribute $celula ref_name]
        # Celulas da arvore de clock (ZCTS*, CTS*) ou fixas nao
        # sao alteradas: o legalizador nao as move, e a troca
        # por uma versao maior sobrepos uma celula vizinha
        # (curto em M1 que reprovou DRC/LVS)
        set status ""
        catch {set status [get_attribute $celula physical_status]}
        if {[string match "*CTS*" [get_object_name $celula]] ||
            $status eq "fixed" || $status eq "application_fixed"} {
            puts "  [get_object_name $celula] ($ref): celula de clock/fixa, mantida"
            continue
        }
        set nova [maior_drive $ref]
        if {$nova ne ""} {
            size_cell $celula $nova
            puts "  [get_object_name $celula]: $ref -> [get_object_name $nova]"
            lappend trocadas [get_object_name $celula]
            continue
        }
        # Celula ja no maior tamanho (ex.: FADDX2): um buffer
        # isola a rede, e a celula passa a dirigir so o buffer
        set rede [get_nets -quiet -of_objects [get_pins $pino]]
        if {[catch {add_buffer -lib_cell [get_lib_cells */NBUFFX4_RVT] \
                $rede} msg]} {
            puts "  $pino ($ref): buffer nao inserido ($msg)"
        } else {
            puts "  [get_object_name $rede]: buffer NBUFFX4 inserido"
            lappend trocadas [get_object_name $rede]
        }
    }

    if {[llength $trocadas] == 0} { break }

    posiciona_e_roteia_eco
}


# ------------------------------------------------------------
# 1c. Incerteza de hold da especificacao
#
# cts.tcl e route.tcl otimizam com 0,20 ns (margem para o
# corner rapido). Relatorios e SDC exportado usam o valor
# da especificacao, 0,10 ns.
# ------------------------------------------------------------

set_clock_uncertainty -hold 0.10 [get_clocks clk]


# ------------------------------------------------------------
# 1d. Limpeza de DRC do roteamento apos os ECOs
#
# O route_eco liga as celulas alteradas, mas pode deixar
# curtos ou espacamentos violados (na primeira execucao:
# 1 curto em M2 entre duas redes, que reprovou o DRC e o LVS).
# O detail route incremental corrige essas violacoes.
# ------------------------------------------------------------

# Garantia: nenhuma sobreposicao de celulas apos os ECOs
redirect -variable legalidade {check_legality}
if {[regexp {([1-9][0-9]*)\s+\d+\s+\d+\s+Two objects overlap} $legalidade]} {
    puts "Aviso: sobreposicao apos ECO; legalizando novamente"
    legalize_placement
    route_eco
    connect_pg_net -automatic
}

route_detail -incremental true -initial_drc_from_input true
connect_pg_net -automatic

report_constraints -all_violators \
    > pnr/reports/finish/violadores.rpt


# ------------------------------------------------------------
# 2. Celulas de preenchimento (filler)
#
# Preenchem os espacos vazios das linhas de celulas, dando
# continuidade aos poços (well) e aos rails de alimentacao.
# Ordem decrescente de largura.
# ------------------------------------------------------------

# A lista precisa estar da maior para a menor (aviso CHF-008);
# fora de ordem, apenas SHFILL1 e utilizada.
unset -nocomplain FILLERS
foreach nome {SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT SHFILL1_RVT} {
    append_to_collection FILLERS [get_lib_cells */$nome]
}

if {[sizeof_collection $FILLERS] == 0} {
    puts "ERRO: celulas SHFILL*_RVT nao encontradas na biblioteca."
    return -code error
}

create_stdcell_fillers -lib_cells $FILLERS

connect_pg_net -automatic

remove_stdcell_fillers_with_violation


# ------------------------------------------------------------
# 3. Verificacoes fisicas internas do Fusion Compiler
#
# Verificacao preliminar. O signoff de DRC e LVS e feito
# depois no IC Validator, a partir do GDSII.
# ------------------------------------------------------------

check_legality        > pnr/reports/finish/legality.rpt
check_routes          > pnr/reports/finish/check_routes.rpt
check_pg_drc          > pnr/reports/finish/pg_drc.rpt
check_pg_connectivity > pnr/reports/finish/pg_connectivity.rpt
check_lvs             > pnr/reports/finish/check_lvs.rpt


# ------------------------------------------------------------
# 4. Relatorios finais
# ------------------------------------------------------------

report_qor         > pnr/reports/finish/qor.rpt
report_utilization > pnr/reports/finish/utilization.rpt
report_power       > pnr/reports/finish/power.rpt
report_clock_qor   > pnr/reports/finish/clock_qor.rpt

report_timing -delay_type max -max_paths 10 \
    > pnr/reports/finish/timing_max.rpt

report_timing -delay_type min -max_paths 10 \
    > pnr/reports/finish/timing_min.rpt

report_design -floorplan > pnr/reports/finish/design.rpt


# ------------------------------------------------------------
# 5. Salvar checkpoint final
#
# Remove o checkpoint de uma execucao anterior, se existir.
# ------------------------------------------------------------

catch {remove_blocks -force filtro_pdm/finish}

save_block -label finish


# ------------------------------------------------------------
# 6. Exportacao
# ------------------------------------------------------------

# Netlist para simulacao pos-layout (sem PG e sem fillers)
write_verilog \
    -exclude {pg_objects physical_only_cells leaf_module_declarations} \
    pnr/output/filtro_pdm_pnr.v

# Netlist para LVS (com conexoes VDD/VSS)
write_verilog \
    -exclude {physical_only_cells leaf_module_declarations} \
    pnr/output/filtro_pdm_lvs.v

# Atrasos para simulacao com back-annotation no VCS
write_sdf pnr/output/filtro_pdm_pnr.sdf

# Parasitas extraidos (SPEF)
write_parasitics -output pnr/output/filtro_pdm

# Restricoes finais
write_sdc -output pnr/output/filtro_pdm_pnr.sdc

# Descricao fisica (DEF)
write_def pnr/output/filtro_pdm.def

# GDSII com o layout das standard cells incorporado
write_gds \
    -hierarchy all \
    -long_names \
    -merge_files $STDCELL_GDS \
    pnr/output/filtro_pdm.gds

# GDSII final: textos das portas movidos para as camadas de pino
# (M*PIN), exigidas pelo LVS do SAED32. Somente textos mudam.
exec python3 pnr/scripts/fix_gds_pin_text.py \
    pnr/output/filtro_pdm.gds \
    pnr/output/filtro_pdm_final.gds >@ stdout

puts "Finalizacao: script executado ate o final."
puts "GDSII final: pnr/output/filtro_pdm_final.gds"
