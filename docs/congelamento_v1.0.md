# Congelamento da implementação — versão v1.0-tcc

Registro da versão do filtro PDM (CIC + FIR) usada no TCC, na monografia, no artigo e no pedido de registro de topografia no INPI.

A partir desta versão o RTL, os coeficientes, as netlists, as restrições, o layout e o GDSII não são mais alterados. Uma mudança em qualquer um deles gera uma nova versão, com nova rodada completa de verificação (simulação, STA, ATPG, DRC e LVS) e novos hashes.

## Identificação

| Item | Valor |
|---|---|
| Tag git | `v1.0-tcc` |
| Commit de referência das evidências | `ffb75c2e234d069c3be2004229ab3460ca953744` |
| Data do congelamento | 27/10/2026 |
| Servidor | `srv-microeletronica3`, diretório `~/tcc_filtro` |
| Tecnologia | SAED32 1P9M RVT |
| Ferramentas | Synopsys VCS/Verdi, Design Compiler, TestMAX ATPG, Fusion Compiler, PrimeTime, IC Validator |
| Layout que identifica a topografia | `pnr/output/filtro_pdm_final.gds` |

A tag é criada no commit que adiciona este documento. Esse commit só acrescenta documentação, então os arquivos de projeto e as evidências são os mesmos do commit de referência.

## Arquitetura congelada

| Bloco | Parâmetros |
|---|---|
| Entrada | PDM de 1 bit, 4,8 MHz |
| CIC | N = 4, R = 16, M = 1 (4,8 MHz → 300 kHz) |
| FIR | 65 coeficientes simétricos, Q1.15, acumulador de 34 bits |
| Saída | 19 bits, 300 kHz |
| DFT | 1 cadeia de scan, 1.332 flip-flops |

## Hashes SHA-256

Calculados no servidor em 27/10/2026, com a árvore de trabalho limpa no commit de referência. A lista completa, no formato do `sha256sum`, está em [congelamento_v1.0.sha256](congelamento_v1.0.sha256).

O GDSII e o SPEF não são versionados (tamanho). Os hashes deles registram as cópias do servidor. Os demais arquivos estão no repositório, e os hashes conferem com os da tag.

### Layout e parasitas (não versionados)

| Arquivo | Bytes | Data | SHA-256 |
|---|---:|---|---|
| `pnr/output/filtro_pdm_final.gds` | 17.774.592 | 22/10 11:44 | `4819ebd52ac6ecfb8fae78e2e0d5188e582eb10c51a1d9c84e57153b92308403` |
| `pnr/output/filtro_pdm.gds` | 17.774.592 | 22/10 11:44 | `69a7e5f628201616cb5c8e62e1a1ae7f961c4f67828d60b7610f4eae08f54cc5` |
| `pnr/output/filtro_pdm.Cmax_25.spef` | 18.439.055 | 22/10 11:44 | `e138b9cec836057405053dddff89f5de7efc2f06a0e19409b60aef671df658b1` |
| `pnr/output/filtro_pdm.Cmin_25.spef` | 18.448.197 | 22/10 11:44 | `abc7a4a7276f43dda8bd0a397a746ed9569bd21bd9ba1650f4a70a94299ad980` |
| `pnr/output/filtro_pdm.Cmin_-40.spef` | 18.448.198 | 22/10 11:44 | `a0fb6bc6306ebb27b18291b640753d636f8c637311a08c73109e61500ab2c5f2` |

`filtro_pdm.gds` é a saída do `write_gds`. `filtro_pdm_final.gds` é o mesmo layout com os textos das portas movidos para as camadas de pino (`pnr/scripts/fix_gds_pin_text.py`), exigidas pelo LVS do SAED32. Só os textos mudam, por isso o tamanho é igual e o hash é diferente. O DRC, o LVS e o registro usam o `filtro_pdm_final.gds`.

### Netlists, restrições e atrasos

| Arquivo | Bytes | Data | SHA-256 |
|---|---:|---|---|
| `synth/netlist/filtro_pdm_syn.v` | 1.021.916 | 09/10 20:38 | `5f21b12a4cb80e3120afc1adba44c234ce1f916599bf39ed93f30c24156f6341` |
| `synth/netlist/filtro_pdm_syn.sdc` | 5.015 | 09/10 20:38 | `68036f700e5421e472f22821d6cb77c6ceaa8d2207078e01c2ba8048d3979466` |
| `pnr/output/filtro_pdm_pnr.v` | 1.426.534 | 22/10 11:44 | `07226b8dccb753d4972b49495febb31e3bafe252f624c5734956fd1b6cdc5779` |
| `pnr/output/filtro_pdm_lvs.v` | 1.767.660 | 22/10 11:44 | `e09902c46edcca4f7154ea525c5dcbfc3e16efc83e29098b4be0613b687368d4` |
| `pnr/output/filtro_pdm_pnr.sdc` | 13.519 | 22/10 11:44 | `e7125c1ecdd7d3a222e16acb52dc6e2a8846d71ff2b350917d95b04517f302dc` |
| `pnr/output/filtro_pdm.spef_scenario` | 405 | 22/10 11:44 | `42d79f28a35d234ef23a008c8e4de9f264f5419a727f586e0178c14bf662f570` |
| `pnr/output/filtro_pdm_pnr_pt.sdf` | 6.039.104 | 22/10 11:50 | `dc3f0c768a6115b4adb39a3d406b000567c25ce38d5ba24af2be6d0666e7bd35` |

### Teste (DFT e ATPG pós-layout)

| Arquivo | Bytes | Data | SHA-256 |
|---|---:|---|---|
| `synth/netlist/filtro_pdm_syn.spf` | 9.705 | 09/10 20:38 | `bf650f2ed88902a96f36f94f430f7b36fd01b8875ab247206e59f8673e490ca3` |
| `atpg/spf/filtro_pdm_transition.spf` | 9.732 | 27/10 14:37 | `78d2f51111312294e840fbd8016329e9fd1ecb3f6ec9374d1329dad1a8f7914b` |
| `atpg/output/pnr/filtro_pdm_stuck.stil` | 332.715 | 22/10 11:52 | `073f43f8d826f3120c0cecb7ebe4f5f9f7f07e18988bcf18099f1f24866988bd` |
| `atpg/output/pnr/filtro_pdm_transition.stil` | 561.083 | 27/10 14:38 | `bca0d96e136e68f56657fd9a22fb6bdd0cfda3142691b94eeaf06b72cda3209c` |

O SPF e os padrões de transition são de 27/10 porque foram gerados de novo na correção do aviso V14 (`docs/auditoria_final.md`). O layout e a netlist não mudaram nessa correção.

### Coeficientes e RTL

| Arquivo | SHA-256 |
|---|---|
| `vectors/fir_coef_q15.txt` | `2c297e4e4ee12f32d88c16689a7ac4902251331e2464b9d1db79ca46aee8a37f` |
| `rtl/filtro_pdm.sv` | `65da684b3e6da5492e2f6465433b022b36af14722af7a1d08ddc5a07c457b3de` |
| `rtl/cic.sv` | `41f1fe51b1523d3aed09fcc1a239509304e7ec4c880c5c0254ce91cd59dc6321` |
| `rtl/cic_integradores.sv` | `019c9721b6c4292aa6d755e5ee3e4207955bf467c2db276f57f94ca6ec54e016` |
| `rtl/cic_combs.sv` | `dc846125b35ece7c83bc76838704b0b676c0cb5c8fa548bc864e8d0648e6fcd1` |
| `rtl/cic_parcial.sv` | `c4c25ebf3cea8bf92349cd0b7f1c6665d778b50e5ac28efbcf8d7d7e1654ecf3` |
| `rtl/integrador.sv` | `329e80b8751b0c41587c9870322ef4638955d4b08982adde50ab8685ce85119d` |
| `rtl/comb.sv` | `28e1bf4def27dca3aa9f10ccf6e12fcd7bf254d169a47e35c8a657a94b9e33f5` |
| `rtl/decimador.sv` | `2b78cd3272c96bb8cd42502ce6bfd935a194c8b1e282fa65aba1e3b343fb5534` |
| `rtl/fir.sv` | `77e716c306158c957b061d5496c4e4aa3ad4b0ca3668c648613b6dec7bbb8cb2` |
| `rtl/fir_antes_sintese.sv` | `fd7342b2f0d628a46355721f8ddf9e4c87767a14a0d16488c6adb3948847b19c` |

`fir_antes_sintese.sv` é histórico e não faz parte do projeto sintetizado (ver README).

## Conferência

Na raiz do projeto:

```bash
sha256sum -c docs/congelamento_v1.0.sha256
```

Todas as linhas devem terminar em `OK`. Em uma cópia do repositório sem o GDSII e o SPEF, esses arquivos aparecem como ausentes. Os demais devem conferir.

## Resultados desta versão

Corner típico tt0p85v25c e clock de 4,8 MHz, salvo indicação.

| Verificação | Resultado |
|---|---|
| Simulação RTL × Golden Model | 10/10 testes; 6.000 amostras por bloco, 0 divergências |
| Simulação gate-level pós-síntese | 10/10 testes, saídas idênticas às de referência |
| Simulação pós-layout com SDF (PrimeTime) | 10/10 testes; anotação sem erros ou avisos; 0 violações de timing |
| STA (tt / ss / ff × funcional / scan, incerteza de hold 0,10 ns) | 0 violações de setup e hold |
| Folga de setup (tt / ss / ff) | +60,20 / +56,80 / +61,87 ns |
| Folga de hold, funcional (tt / ss / ff) | +0,1330 / +0,3570 / +0,0105 ns |
| Folga de hold, scan (tt / ss / ff) | +0,1330 / +0,3570 / +0,0098 ns |
| Capacitância e transição máximas | 0 violações |
| ATPG pós-layout | stuck-at 98,57% (92 padrões); transition 97,27% (165 padrões) |
| Simulação dos padrões ATPG (carga serial, sem atraso e com SDF) | 0 divergências |
| DRC (IC Validator) | CLEAN (396 regras) |
| LVS (IC Validator) | comparação PASS, 0 violações de regra |
| Core / chip | 240 × 240 µm (57.349 µm²) / 67.328 µm² |
| Área de células / utilização | 40.705 µm² / 71,0% |
| Células (sem fillers) | 10.067 |
| Potência (SAIF, 50 kHz com ruído) | dinâmica 53,4 µW; fuga 1,26 mW; total 1,31 mW |

## Desempenho do filtro

Medido a partir das saídas do hardware (`docs/desempenho_filtro.md`).

| Métrica | Resultado |
|---|---|
| Ondulação na banda 20–80 kHz | 0,235 dB medida (teórica 0,175 dB) |
| Frequência de −3 dB | 90,6 kHz na varredura (teórica 88,8 kHz) |
| Rejeição a 130 kHz (teste 08) | ≥ 104,4 dB (requisito > 80 dB) |
| Atenuação teórica acima de 110 kHz | 88,0 dB |
| SNR, teste 03 | 62,7 dB (ENOB 10,1) |
| Latência | 33 amostras de saída (110 µs) |

## Documentos relacionados

- [auditoria_final.md](auditoria_final.md): portas de saída, protocolo do ATPG, simulação dos padrões e scripts.
- [auditoria_sta.md](auditoria_sta.md): corners, modos e hold.
- [auditoria_sdf.md](auditoria_sdf.md): SDF para a simulação pós-layout.
- [desempenho_filtro.md](desempenho_filtro.md): resposta em frequência, rejeição, SNR e latência.
