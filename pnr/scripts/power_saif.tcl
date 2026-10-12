# ============================================================
# power_saif.tcl
# Analise de potencia com atividade de simulacao (SAIF)
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# Tecnologia: SAED32 RVT (tt0p85v25c)
#
# Uso (a partir da raiz do repositorio):
#
#   sim/scripts/run_saif.sh
#   fc_shell -f pnr/scripts/power_saif.tcl
#
# Entrada:  filtro_pdm/finish
#           pnr/activity/filtro_pdm.saif
# Saida:    pnr/reports/power_saif/
#
# A potencia de finish.tcl (power.rpt) e "vectorless": usa
# taxas de chaveamento padrao. Aqui as taxas vem da simulacao
# pos-layout (SDF) com um sinal de ultrassom real.
#
# O bloco NAO e salvo: ao final, saia com "exit" e responda
# que nao deseja salvar, se perguntado.
# ============================================================

set SAIF pnr/activity/filtro_pdm.saif

# Hierarquia do DUT dentro do testbench
set CAMINHO_DUT tb_filtro_pdm_golden/dut

if {![file exists $SAIF]} {
    puts "ERRO: $SAIF nao encontrado. Execute sim/scripts/run_saif.sh"
    return -code error
}

file mkdir pnr/reports/power_saif

open_lib pnr/work/filtro_pdm.dlib
open_block filtro_pdm/finish


# ------------------------------------------------------------
# 1. Potencia sem vetores (referencia)
# ------------------------------------------------------------

report_power > pnr/reports/power_saif/power_vectorless.rpt


# ------------------------------------------------------------
# 2. Leitura da atividade simulada
# ------------------------------------------------------------

read_saif $SAIF -strip_path $CAMINHO_DUT

# Quantas redes receberam atividade da simulacao
catch {report_activity > pnr/reports/power_saif/activity.rpt}


# ------------------------------------------------------------
# 3. Potencia com a atividade simulada
# ------------------------------------------------------------

report_power > pnr/reports/power_saif/power.rpt

# Divisao por bloco (CIC x FIR)
if {[catch {report_power -hierarchy \
        > pnr/reports/power_saif/power_hier.rpt} msg]} {
    puts "Aviso: relatorio hierarquico nao gerado ($msg)"
}

puts ""
puts "Potencia com SAIF: pnr/reports/power_saif/power.rpt"
puts "Referencia sem vetores: pnr/reports/power_saif/power_vectorless.rpt"
puts "Bloco nao salvo. Saia com: exit"
