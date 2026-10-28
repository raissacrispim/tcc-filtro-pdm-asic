# ============================================================
# fc_imagens.tcl
# Imagens do layout gravadas pelo proprio Fusion Compiler
# Projeto: Filtro PDM CIC + FIR (versao v1.0-tcc)
#
# Uso (terminal dentro da sessao X2Go, fora do projeto):
#
#   mkdir -p ~/tcc_imagens_fc && cd ~/tcc_imagens_fc
#   fc_shell -gui -f ~/tcc_filtro/imagens/scripts/fc_imagens.tcl \
#       | tee fc_imagens.log
#
# Somente leitura: a biblioteca e os blocos sao abertos com
# -read e nada e salvo. Os logs do FC ficam no diretorio de
# execucao (~/tcc_imagens_fc), fora do projeto.
#
# Saida: docs/imagens/layout/*.png, gravados com
# gui_write_window_image a partir da janela de layout, em
# 1800 x 1800 pixels (-size), independente do tamanho da janela.
# Os arquivos .idf gravados junto pelo FC nao sao versionados
# (.gitignore).
# Cada vista e independente: se um comando da GUI nao existir
# nesta versao do FC, a falha e listada no final e as demais
# imagens continuam. A GUI fica aberta ao final.
# ============================================================

set sh_continue_on_error true

set PROJ [file normalize ~/tcc_filtro]
if {[info exists ::env(TCC_PROJ)]} { set PROJ [file normalize $::env(TCC_PROJ)] }
set SAIDA $PROJ/docs/imagens/layout
file mkdir $SAIDA

set FALHAS {}
set GRAVADAS {}

proc falha {desc msg} {
    global FALHAS
    puts "FALHOU: $desc ($msg)"
    lappend FALHAS "$desc: $msg"
}

# Janela de layout atual (cria uma se nao houver)
proc janela {} {
    set w [gui_get_current_window -types Layout -mru]
    if {$w eq ""} {
        catch {gui_create_window -type LayoutWindow}
        set w [gui_get_current_window -types Layout -mru]
    }
    return $w
}

proc limpa_destaques {} {
    catch {gui_change_highlight -remove -all_colors}
}

proc vista_completa {} {
    if {[catch {gui_zoom -window [janela] -full} msg]} {
        falha "zoom completo" $msg
    }
}

# Qualidade de desenho "High quality" com anti-alias (View
# Settings > Settings > Small object filtering). No padrao "Max
# speed", objetos menores que um pixel nao sao desenhados: na
# vista do chip inteiro os fios de roteamento e a rede de
# alimentacao desaparecem.
proc alta_qualidade {w} {
    if {[catch {
        gui_set_setting -window $w -setting renderQuality -value 1
        gui_set_setting -window $w -setting renderAntiAlias -value true
    } msg]} {
        falha "qualidade de desenho" $msg
    }
}

# Tamanho da imagem: -size grava a vista num tamanho fixo,
# independente da janela (o chip e quadrado: 240 x 240 um).
set TAMANHO 1800
set FORMA_TAMANHO ""

proc grava {nome} {
    global SAIDA GRAVADAS TAMANHO FORMA_TAMANHO
    set w [janela]
    alta_qualidade $w
    set arq $SAIDA/$nome.png
    set gravou 0
    foreach forma [list "$TAMANHO $TAMANHO" "${TAMANHO}x${TAMANHO}" ""] {
        if {$FORMA_TAMANHO ne "" && $forma ne $FORMA_TAMANHO} { continue }
        set opcoes [list -window $w -file $arq -format png]
        if {$forma ne ""} { lappend opcoes -size $forma }
        if {![catch {gui_write_window_image {*}$opcoes} msg]} {
            set gravou 1
            if {$FORMA_TAMANHO eq ""} {
                set FORMA_TAMANHO $forma
                puts "Tamanho da imagem: -size {$forma}"
            }
            break
        }
        puts "Aviso: gui_write_window_image -size {$forma} nao aceito ($msg)"
    }
    if {!$gravou} {
        falha "gravar $nome" "gui_write_window_image"
        return
    }
    puts "Gravada: $arq"
    lappend GRAVADAS $nome
}

proc destaca {desc cor colecao} {
    if {[sizeof_collection $colecao] == 0} {
        falha "destacar $desc" "colecao vazia"
        return
    }
    if {[catch {gui_change_highlight -add -color $cor -collection $colecao} msg]} {
        falha "destacar $desc" $msg
    } else {
        puts "Destacado ($cor): $desc, [sizeof_collection $colecao] objetos"
    }
}

proc abre_etapa {rotulo} {
    catch {close_blocks -force [get_blocks -all]}
    if {[catch {open_block -read filtro_pdm/$rotulo} msg]} {
        falha "abrir bloco $rotulo" $msg
        return 0
    }
    janela
    limpa_destaques
    vista_completa
    return 1
}


# ------------------------------------------------------------
# 1. Biblioteca do projeto (somente leitura)
# ------------------------------------------------------------

catch {start_gui}

# Opcoes do comando de gravacao nesta versao (para o log)
catch {help -verbose gui_write_window_image}
if {[catch {open_lib -read $PROJ/pnr/work/filtro_pdm.dlib} msg]} {
    falha "abrir biblioteca" $msg
}


# ------------------------------------------------------------
# 2. Uma imagem por etapa do fluxo
# ------------------------------------------------------------

foreach {rotulo nome} {
    floorplan              01_floorplan
    power_plan_reproduzido 02_rede_alimentacao
    place                  03_posicionamento
    cts                    04_arvore_clock
    route                  05_roteamento
    finish                 06_chip_completo
} {
    if {![abre_etapa $rotulo]} { continue }
    switch $rotulo {
        floorplan {
            # Core vazio: as linhas de sites mostram onde as
            # celulas serao posicionadas
            destaca "linhas de sites" light_blue [get_site_rows -quiet *]
        }
        power_plan_reproduzido {
            # So ha a rede de alimentacao: destaque para que o anel
            # e os straps aparecam na vista do chip inteiro
            destaca "VDD" red  [get_nets -quiet {VDD}]
            destaca "VSS" blue [get_nets -quiet {VSS}]
        }
    }
    grava $nome
}


# ------------------------------------------------------------
# 3. Vistas do layout final (bloco finish)
# ------------------------------------------------------------

if {[abre_etapa finish]} {

    # FIR (hierarquia u_fir) x CIC, decimador e logica de topo
    set fir [get_cells -quiet -hierarchical \
        -filter "is_hierarchical==false && full_name=~u_fir/*"]
    set topo [get_cells -quiet \
        -filter "is_hierarchical==false && is_physical_only==false"]
    destaca "FIR (u_fir)" yellow $fir
    destaca "CIC e logica de topo" light_blue $topo
    grava 07_blocos_cic_fir
    limpa_destaques

    # Redes de clock
    set redes_clk [get_nets -quiet -hierarchical -filter "net_type==clock"]
    if {[sizeof_collection $redes_clk] == 0} {
        set redes_clk [get_nets -quiet -hierarchical {clk ZCTSNET_*}]
    }
    destaca "redes de clock" red $redes_clk
    grava 08_redes_clock
    limpa_destaques

    # Alimentacao
    destaca "VDD" red    [get_nets -quiet {VDD}]
    destaca "VSS" blue   [get_nets -quiet {VSS}]
    grava 09_vdd_vss
    limpa_destaques

    # Portas de I/O
    set portas [get_ports -quiet *]
    destaca "portas de I/O" orange $portas
    grava 10_portas_io
    limpa_destaques

    # Detalhe: regiao de 20 x 20 um no centro do core
    if {[catch {gui_zoom -window [janela] -rect {{110 110} {130 130}}} msg]} {
        falha "zoom no detalhe" $msg
    } else {
        grava 11_detalhe_celulas
    }

    # Mapa de densidade de celulas
    vista_completa
    set mapa_ok 0
    foreach m {cellDensityMap {Cell Density} {Cell Density Map}} {
        if {![catch {gui_show_map -window [janela] -map $m -show true}]} {
            set mapa_ok 1
            grava 12_densidade_celulas
            catch {gui_show_map -window [janela] -map $m -show false}
            break
        }
    }
    if {!$mapa_ok} { falha "mapa de densidade" "gui_show_map nao aceito" }
}


# ------------------------------------------------------------
# 4. Resumo
# ------------------------------------------------------------

puts ""
puts "============================================"
puts "IMAGENS DO LAYOUT"
puts "============================================"
puts "Gravadas: [llength $GRAVADAS] em $SAIDA"
foreach g $GRAVADAS { puts "  $g.png" }
puts "Falhas:   [llength $FALHAS]"
foreach f $FALHAS { puts "  $f" }
puts "============================================"
puts "A GUI continua aberta para inspecao. Nada foi salvo nos blocos."
