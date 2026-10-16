`timescale 1ns/1ps
// Mede no simulador o atraso de clock (porta clk -> pino CLK) e o
// CLK->Q de um flip-flop, para comparar com o SDF e o PrimeTime.
// Compilado como segundo top-level: -top tb_filtro_pdm_golden -top mede_clkq
module mede_clkq;
`define FF tb_filtro_pdm_golden.dut.u_cic_u_integradores_int3_reg_0_
  realtime t_porta = 0, t_clk = 0;
  integer n = 0;
  always @(posedge tb_filtro_pdm_golden.clk) t_porta = $realtime;
  always @(posedge `FF.CLK) t_clk = $realtime;
  always @(`FF.Q) if (n < 8 && t_clk > 0) begin
    n = n + 1;
    $display("MEDE: Q=%b  porta clk -> pino CLK = %.3f ns   CLK->Q = %.3f ns",
             `FF.Q, t_clk - t_porta, $realtime - t_clk);
  end
endmodule
