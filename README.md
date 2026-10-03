# Filtro Digital PDM para Sinais Ultrassônicos

Projeto de implementação em hardware de um filtro digital para processamento de sinais ultrassônicos modulados por densidade de pulso (PDM).

O projeto faz parte do desenvolvimento de um ASIC utilizando fluxo baseado em standard cells.

## Arquitetura

A cadeia de processamento implementada é:

PDM 1 bit @ 4,8 MHz
→ conversão 0/1 para -1/+1
→ filtro CIC
→ decimação por 16
→ filtro FIR compensador
→ saída digital de 19 bits @ 300 kHz

### CIC

- Ordem: N = 4
- Fator de decimação: R = 16
- Atraso diferencial: M = 1
- Largura interna: 17 bits
- Frequência de entrada: 4,8 MHz
- Frequência de saída: 300 kHz

### FIR

- 65 coeficientes
- Coeficientes em Q1.15
- Entrada: 17 bits
- Acumulador: 34 bits
- Saída: 19 bits
- Compensação da queda na banda passante do CIC

## Estrutura

- `rtl/`: módulos SystemVerilog sintetizáveis
- `tb/`: testbenches de verificação
- `vectors/`: vetores de entrada e resultados do Golden Model

## Verificação

A implementação RTL foi comparada amostra por amostra com um Golden Model para seis vetores de teste:

- senoide de 10 kHz
- senoide de 30 kHz
- senoide de 50 kHz
- senoide de 80 kHz
- 50 kHz com ruído
- burst de 50 kHz com ruído

Cada teste utiliza 9.600 amostras PDM e produz 600 amostras de saída.

Foram comparadas 3.600 amostras de saída no total, sem divergências entre o RTL e o Golden Model para o conjunto de testes utilizado.

## Ferramentas

A simulação e depuração RTL foram realizadas utilizando ferramentas Synopsys, incluindo VCS e Verdi.

O projeto seguirá posteriormente para síntese lógica e implementação física ASIC.
