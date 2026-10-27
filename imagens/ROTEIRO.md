# Roteiro das imagens (versão v1.0-tcc)

Todas as imagens da documentação são produzidas pelas ferramentas no servidor, a partir dos dados do projeto congelado: Fusion Compiler (layout) e Verdi (formas de onda das simulações VCS). Nenhuma imagem é desenhada ou gerada por IA.

As imagens ficam em `docs/imagens/`:

| Pasta | Origem |
|---|---|
| `docs/imagens/layout/` | Fusion Compiler, `gui_write_window_image` (`imagens/scripts/fc_imagens.tcl`) |
| `docs/imagens/simulacao/` | Verdi, captura da janela de formas de onda |

Tudo roda dentro da sessão **X2Go** (área de trabalho remota), que já tem a interface gráfica.

## 0. Preparação (uma vez)

Num terminal dentro do X2Go:

```bash
echo "DISPLAY=$DISPLAY"
which fc_shell verdi import 2>&1
```

- `DISPLAY` deve ter um valor, por exemplo `:50`.
- `import` (ImageMagick) grava a imagem de uma janela. Se não existir, use a ferramenta de captura da área de trabalho do X2Go e salve no mesmo nome e pasta.

## 1. Layout (Fusion Compiler)

```bash
mkdir -p ~/tcc_imagens_fc && cd ~/tcc_imagens_fc
fc_shell -gui -f ~/tcc_filtro/imagens/scripts/fc_imagens.tcl | tee fc_imagens.log
```

O script abre a biblioteca e os blocos somente para leitura e grava, sem salvar nada no projeto:

| Arquivo | Conteúdo |
|---|---|
| `01_floorplan.png` | Core de 240 × 240 µm e pinos (bloco `floorplan`) |
| `02_rede_alimentacao.png` | Anel M8/M9, straps e rails (bloco `power_plan_reproduzido`) |
| `03_posicionamento.png` | Células posicionadas (bloco `place`) |
| `04_arvore_clock.png` | Após a síntese da árvore de clock (bloco `cts`) |
| `05_roteamento.png` | Após o roteamento (bloco `route`) |
| `06_chip_completo.png` | Layout final (bloco `finish`) |
| `07_blocos_cic_fir.png` | FIR em amarelo; CIC, decimador e lógica de topo em azul |
| `08_redes_clock.png` | Redes de clock destacadas |
| `09_vdd_vss.png` | VDD (vermelho) e VSS (azul) |
| `10_portas_io.png` | Portas de I/O |
| `11_detalhe_celulas.png` | Zoom de 20 × 20 µm no centro do core |
| `12_densidade_celulas.png` | Mapa de densidade de células |

Ao final, o terminal lista as imagens gravadas e as **falhas**: os comandos da GUI que esta versão do FC não aceitou. Mande essa lista; eu ajusto o script. A GUI fica aberta para você explorar. Feche com `exit` **no prompt do fc_shell**, não no terminal do X2Go.

Se `gui_write_window_image` não funcionar, monte a vista na GUI e grave a janela com:

```bash
import ~/tcc_filtro/docs/imagens/layout/06_chip_completo.png
```

O cursor vira uma cruz; clique na janela do FC.

## 2. Simulações (VCS + Verdi)

### 2.1 Gerar as formas de onda

```bash
bash ~/tcc_filtro/imagens/scripts/sim_ondas.sh
```

O script clona o projeto na tag `v1.0-tcc` em `~/tcc_imagens_sim`. Lá, compila o RTL e a netlist pós-layout com SDF e roda cada teste numa pasta própria, `onda_rtl_<teste>` ou `onda_pnr_<teste>`. Cada teste deve sair `[PASS]`. O projeto em `~/tcc_filtro` não é tocado.

### 2.2 Abrir no Verdi

RTL:

```bash
cd ~/tcc_imagens_sim/onda_rtl_test_09_varredura
verdi -dbdir ../sim/simv_filtro_rtl.daidir -ssf filtro_pdm.fsdb &
```

Pós-layout com SDF:

```bash
cd ~/tcc_imagens_sim/onda_pnr_test_09_varredura
verdi -dbdir ../sim/simv_filtro_gls.daidir -ssf filtro_pdm.fsdb &
```

Configuração comum na janela de formas de onda (nWave):

- Adicione os sinais pelo painel de hierarquia: `tb_filtro_pdm_golden` → `dut`. Selecione o sinal e clique em *Add* (ou use o botão do meio do mouse).
- Em `y_out` (e `cic_out`): defina o radix como decimal com sinal, complemento de dois (botão direito → *Set Radix* → *2's Complement*). Depois mude para forma analógica (botão direito → *Analog Waveform*) e aumente a altura do sinal.
- Para ver o teste inteiro, use *Zoom All* (tecla `f`).

Os nomes dos menus podem variar um pouco conforme a versão do Verdi.

### 2.3 Capturas

| Arquivo | Simulação | Sinais | Vista |
|---|---|---|---|
| `s01_varredura_rtl.png` | `onda_rtl_test_09_varredura` | `pdm_in`, `y_out` (analógico) | teste inteiro |
| `s02_varredura_pos_layout.png` | `onda_pnr_test_09_varredura` | `pdm_in`, `y_out` (analógico) | teste inteiro |
| `s03_interferencia_130k.png` | `onda_rtl_test_08_50k_interf_130k` | `pdm_in`, `dut.cic_out` e `y_out` (analógicos) | ~0,3 ms no meio do teste |
| `s04_impulso.png` | `onda_rtl_test_10_impulso` | `pdm_in`, `y_out` (analógico) | zoom na resposta (≈ 0,7 a 1,0 ms) |
| `s05_seno_10k.png` | `onda_rtl_test_01_10k` | `y_out` (analógico) | teste inteiro |
| `s06_seno_50k.png` | `onda_rtl_test_03_50k` | `y_out` (analógico) | ~0,2 ms |
| `s07_seno_80k.png` | `onda_rtl_test_04_80k` | `y_out` (analógico) | ~0,2 ms |
| `s08_detalhe_decimacao.png` | `onda_rtl_test_03_50k` | `clk`, `pdm_in`, `dut.cic_valid`, `valid_out`, `y_out` (decimal) | ~10 µs: `cic_valid` a cada 16 ciclos de clock |
| `s09_atraso_pos_layout.png` | `onda_pnr_test_09_varredura` | `clk`, `valid_out`, `y_out` (barramento) | ~20 ns em torno de uma borda de clock: atraso real das células |
| `s10_interferencia_pos_layout.png` | `onda_pnr_test_08_50k_interf_130k` | `pdm_in`, `y_out` (analógico) | mesma vista de `s03` |

`cic_out` e `cic_valid` existem só no RTL. Na netlist pós-layout, a hierarquia do CIC foi achatada.

Grave cada uma clicando na janela do Verdi:

```bash
mkdir -p ~/tcc_filtro/docs/imagens/simulacao
import ~/tcc_filtro/docs/imagens/simulacao/s01_varredura_rtl.png
```

### Como ler a varredura (teste 09)

A entrada é um chirp linear de 0 a 150 kHz em 2 ms (9.600 bits PDM). A frequência cresce 75 kHz por ms, contados a partir do primeiro bit PDM. Por isso a envoltória de `y_out` é a própria resposta em frequência:

- até ~1,07 ms (80 kHz): amplitude constante (banda útil);
- de 1,07 a 1,47 ms (80 a 110 kHz): transição;
- depois de ~1,47 ms (110 kHz): saída praticamente nula (banda de rejeição).

A saída chega atrasada em relação à entrada em cerca de 110 µs, a latência do filtro (33 amostras). No Verdi, você pode marcar esses instantes com cursores e marcadores antes da captura.

## 3. Publicação

Confira se o congelamento continua íntegro e envie só as imagens:

```bash
cd ~/tcc_filtro
sha256sum -c docs/congelamento_v1.0.sha256 | grep -v SUCESSO
git status --short
git add docs/imagens
git commit -m "Imagens do layout (Fusion Compiler) e das simulacoes (Verdi)"
git push origin main
```

O primeiro comando não deve imprimir nada. O `git status --short` deve mostrar apenas `docs/imagens/`.

Depois do push, eu monto `docs/imagens.md` com cada imagem, a ferramenta e o comando que a gerou.
