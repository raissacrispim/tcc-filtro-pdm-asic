#!/bin/bash
# ============================================================
# cc_importa_gds.sh
# GDSII congelado (v1.0-tcc) no Custom Compiler
# Projeto: Filtro PDM CIC + FIR
#
# Uso:
#
#   bash ~/tcc_filtro/imagens/scripts/cc_importa_gds.sh
#
# Cria ~/cc_v1 (outro local: TCC_CC=<dir>) com um lib.defs
# proprio e importa pnr/output/filtro_pdm_final.gds na
# biblioteca chip_filtro_v1, com as mesmas opcoes da importacao
# de 14/10 (~/cc_saed32/importStream.*.log). Antes, confere o
# SHA-256 do GDS contra docs/congelamento_v1.0.sha256.
#
# Nao altera ~/cc_saed32 nem o projeto.
# ============================================================

set -o pipefail

PROJ=${TCC_PROJ:-$HOME/tcc_filtro}
DEST=${TCC_CC:-$HOME/cc_v1}
GDS=$PROJ/pnr/output/filtro_pdm_final.gds
LIB=chip_filtro_v1
export SAED32_28_PDK=${SAED32_28_PDK:-/Tools/PDK/SAED32_PDK}

if ! command -v importStream > /dev/null; then
    echo "ERRO: importStream nao encontrado."
    echo "Execute antes: source /Tools/synopsys-scripts/snps.sh"
    exit 1
fi
if [ -e "$DEST" ]; then
    echo "ERRO: $DEST ja existe e nao sera alterado."
    echo "Use outro diretorio: TCC_CC=~/cc_v1b bash $0"
    exit 1
fi

# GDS congelado?
ESPERADO=$(grep " pnr/output/filtro_pdm_final.gds$" \
    "$PROJ/docs/congelamento_v1.0.sha256" | cut -d' ' -f1)
ATUAL=$(sha256sum "$GDS" | cut -d' ' -f1)
if [ -z "$ESPERADO" ] || [ "$ATUAL" != "$ESPERADO" ]; then
    echo "ERRO: o GDS nao confere com o congelamento v1.0-tcc."
    echo "  esperado: $ESPERADO"
    echo "  atual:    $ATUAL"
    exit 1
fi
echo "GDS conferido (v1.0-tcc): $ATUAL"

mkdir -p "$DEST" || exit 1
cd "$DEST" || exit 1
cat > lib.defs <<FIM
INCLUDE \$SAED32_28_PDK/lib.defs
DEFINE $LIB ./$LIB
FIM

LOG=$DEST/importStream_v1.log
importStream -logFile "$LOG" \
    -lib $LIB -libDefFile "$DEST/lib.defs" -DMSystem oaDMFileSys \
    -libPath "$DEST/$LIB" -techLib SAED_PDK_32_28 \
    -gds "$GDS" -cell filtro_pdm -hierDepth 256 -propSeparator , \
    -view layout -filterDots -useTechLayerMap -useTechObjectMap \
    > /dev/null 2>&1

echo "============================================"
grep -E "Messages:|Cells:|Rectangles:|Paths:|Text:" "$LOG"
if grep -q "Messages: *0 error" "$LOG" && [ -d "$DEST/$LIB/filtro_pdm/layout" ]; then
    echo "IMPORTACAO OK: $LIB/filtro_pdm/layout em $DEST"
    echo "Abra com: cd $DEST && custom_compiler &"
else
    echo "IMPORTACAO COM ERRO: ver $LOG"
fi
echo "============================================"
