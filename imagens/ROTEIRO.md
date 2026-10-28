# Roteiro das imagens (versão v1.0-tcc)

Todas as imagens da documentação são produzidas pelas ferramentas no servidor, a partir dos dados do projeto congelado: Fusion Compiler (layout) e Verdi (formas de onda das simulações VCS). Nenhuma imagem é desenhada ou gerada por IA.

As imagens ficam em `docs/imagens/`:

| Pasta | Origem |
|---|---|
| `docs/imagens/layout/` | Fusion Compiler, `gui_write_window_image` (`imagens/scripts/fc_imagens.tcl`) |
| `docs/imagens/simulacao/` | Verdi, captura da janela de formas de onda |

Tudo roda dentro da sessão **X2Go** (área de trabalho remota), que já tem a interface gráfica.

## 0. Preparação (uma vez)

Em **cada terminal novo** dentro do X2Go, carregue o ambiente Synopsys:

```bash
source /Tools/synopsys-scripts/snps.sh
echo "DISPLAY=$DISPLAY"
which fc_shell vcs verdi import 2>&1
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

- Arraste os sinais do painel de hierarquia (`tb_filtro_pdm_golden` → `dut`) para a janela de ondas.
- Em `y_out` (e `cic_out`): *Analog → Convert to Analog*. A curva analógica (`A_y_out`) já usa o valor com sinal. Depois apague a linha digital do barramento (selecione e aperte `Delete`).
- Para ver o teste inteiro, aperte `f` (*Zoom Fit*).
- Arraste para cima a divisória entre o código-fonte e as ondas para aumentar a área das ondas.
- Salve os sinais em *File → Save Signal...* (por exemplo, `~/tcc_imagens_sim/varredura.rc`). Se o Verdi fechar, a vista volta com `-sswr`:

```bash
verdi -dbdir ../sim/simv_filtro_rtl.daidir -ssf filtro_pdm.fsdb -sswr ../varredura.rc &
```

### 2.3 Capturas

| Arquivo | Simulação | Sinais | Vista |
|---|---|---|---|
| `s01_varredura_rtl.png` | `onda_rtl_test_09_varredura` | `pdm_in`, `y_out` (analógico) | teste inteiro |
| `s02_varredura_pos_layout.png` | `onda_pnr_amostra_test_09_varredura` | `pdm_in`, `amostra_saida.y_amostrado` (analógico) | teste inteiro |
| `s03_interferencia_130k.png` | `onda_rtl_test_08_50k_interf_130k` | `pdm_in`, `dut.cic_out` e `y_out` (analógicos) | ~0,3 ms no meio do teste |
| `s04_impulso.png` | `onda_rtl_test_10_impulso` | `pdm_in`, `y_out` (analógico) | zoom na resposta (≈ 0,7 a 1,0 ms) |
| `s05_seno_10k.png` | `onda_rtl_test_01_10k` | `y_out` (analógico) | teste inteiro |
| `s06_seno_50k.png` | `onda_rtl_test_03_50k` | `y_out` (analógico) | ~0,2 ms |
| `s07_seno_80k.png` | `onda_rtl_test_04_80k` | `y_out` (analógico) | ~0,2 ms |
| `s08_detalhe_decimacao.png` | `onda_rtl_test_03_50k` | `clk`, `pdm_in`, `dut.cic_valid`, `valid_out`, `y_out` (decimal) | ~10 µs: `cic_valid` a cada 16 ciclos de clock |
| `s09_atraso_pos_layout.png` | `onda_pnr_test_09_varredura` | `clk`, `valid_out`, `y_out` (barramento) | ~20 ns em torno de uma borda de clock: atraso real das células |
| `s10_interferencia_pos_layout.png` | `onda_pnr_amostra_test_08_50k_interf_130k` | `pdm_in`, `amostra_saida.y_amostrado` (analógico) | mesma vista de `s03` |
| `s11_glitches_pos_layout.png` | `onda_pnr_test_09_varredura` | `y_out` (analógico, sem amostragem) | teste inteiro: picos das trocas de valor |

Na simulação pós-layout com SDF, os bits de `y_out` mudam em instantes ligeiramente diferentes após cada borda de clock. A forma analógica de `y_out` desenha esses valores intermediários (glitches) como picos verticais. Por isso as curvas pós-layout (s02 e s10) usam `amostra_saida.y_amostrado`: é o valor de `y_out` na borda de descida do clock com `valid_out = 1`, o mesmo instante em que o testbench compara a saída com o Golden Model. Esse sinal vem de `imagens/sim/amostra_saida.sv`, um segundo módulo de topo, e é gerado por:

```bash
bash ~/tcc_filtro/imagens/scripts/sim_ondas_amostradas.sh
```

O testbench e o projeto não mudam. A captura s09 mostra o próprio `y_out` no detalhe de nanossegundos, onde o atraso e o desalinhamento dos bits são visíveis.

`cic_out` e `cic_valid` existem só no RTL. Na netlist pós-layout, a hierarquia do CIC foi achatada.

Grave a janela do Verdi pelo identificador. No X2Go, o `import` interativo (clicar ou arrastar) falha com "unable to grab mouse".

```bash
mkdir -p ~/tcc_filtro/docs/imagens/simulacao
xwininfo -root -tree | grep -i "nTraceMain"      # identificador 0x... da janela
sleep 8 && import -window 0x... ~/tcc_filtro/docs/imagens/simulacao/s01_varredura_rtl.png
```

Depois de apertar Enter, traga o Verdi à frente e não mexa mais em nada até a gravação. O terminal não pode ficar por cima da janela. O identificador muda a cada vez que o Verdi é aberto.

### Como ler a varredura (teste 09)

A entrada é um chirp linear de 0 a 150 kHz em 2 ms (9.600 bits PDM). A frequência cresce 75 kHz por ms, contados a partir do primeiro bit PDM. Por isso a envoltória de `y_out` é a própria resposta em frequência:

- até ~1,07 ms (80 kHz): amplitude constante (banda útil);
- de 1,07 a 1,47 ms (80 a 110 kHz): transição;
- depois de ~1,47 ms (110 kHz): saída praticamente nula (banda de rejeição).

A saída chega atrasada em relação à entrada em cerca de 110 µs, a latência do filtro (33 amostras). No Verdi, você pode marcar esses instantes com cursores e marcadores antes da captura.

## 2b. Resposta em frequência em dB (WaveView)

```bash
cd ~/tcc_imagens_sim/onda_rtl_test_10_impulso
wv &
```

1. *Open Waveform* → `filtro_pdm.fsdb`.
2. Arraste `tb_filtro_pdm_golden → dut → y_out` para a área de ondas.
3. Aba *Waveform* → *D to A*:
   - Multiple Bits;
   - Use Logic Bus Value;
   - Signed Digital Value (2's Compliment);
   - sufixo `_analog`.
4. Selecione o sinal convertido. Em *FFT/DFT*:
   - 256 pontos;
   - Sampling Rate `300k`;
   - Start `603.63u`;
   - sem zero-padding e com Stop desmarcado;
   - janela Rectangle;
   - Normalized.

   O zero-padding desloca a escala do eixo de frequência.
5. Grave com `import -window` (janela "WaveView Version"): `docs/imagens/simulacao/s12_fft_resposta_frequencia.png`.

## 2c. GDSII (Custom Compiler)

```bash
bash ~/tcc_filtro/imagens/scripts/cc_importa_gds.sh   # confere o hash e importa em ~/cc_v1
cd ~/cc_v1 && custom_compiler &
```

1. No Library Manager, marque *Open Read-Only*.
2. Abra `chip_filtro_v1 → filtro_pdm → layout`.
3. Ajuste a profundidade de hierarquia para 10. É o segundo campo numérico da barra.
4. Aperte `F` para o chip inteiro (`c01_gds_chip_completo.png`) ou dê zoom de poucas linhas de células (`c05_gds_detalhe_celulas.png`).
5. Grave com `import -window` (janela "Layout Editor") em `docs/imagens/gds/`.

## 2d. Síntese (Design Vision)

```bash
mkdir -p ~/tcc_imagens_dv && cd ~/tcc_imagens_dv
design_vision -f ~/tcc_filtro/imagens/scripts/dv_abre.tcl
```

1. Clique em `filtro_pdm` na hierarquia e abra:
   - *Schematic → New Symbol View* (`d01_dv_simbolo.png`);
   - *Schematic → New Schematic View* (`d02_dv_esquematico_topo.png`).
2. Grave com `import -window` (janela "Design Vision"), numa **outra aba** do terminal. A aba em que o Design Vision foi aberto só aceita comandos dele.

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
