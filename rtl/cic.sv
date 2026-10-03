`timescale 1ns/1ps

module cic #(
    parameter int BITS = 17,
    parameter int R    = 16
)(
    input  logic clk,
    input  logic rst,

    // Entrada PDM bipolar: -1 ou +1
    input  logic signed [BITS-1:0] x_in,

    // Saída do CIC
    output logic signed [BITS-1:0] y_out,
    output logic                   valid_out
);

    // ============================================================
    // SAÍDAS DOS QUATRO INTEGRADORES
    // ============================================================

    logic signed [BITS-1:0] int1;
    logic signed [BITS-1:0] int2;
    logic signed [BITS-1:0] int3;
    logic signed [BITS-1:0] int4;

    // ============================================================
    // SINAIS DO DECIMADOR
    // ============================================================

    logic [$clog2(R)-1:0] dec_count;
    logic                  dec_valid;


    // ============================================================
    // 4 INTEGRADORES
    //
    // Taxa de processamento: 4,8 MHz
    // ============================================================

    cic_integradores #(
        .BITS(BITS)
    ) u_integradores (
        .clk  (clk),
        .rst  (rst),
        .x_in (x_in),

        .int1 (int1),
        .int2 (int2),
        .int3 (int3),
        .int4 (int4)
    );


    // ============================================================
    // DECIMADOR R = 16
    //
    // Gera um pulso de valid a cada 16 clocks.
    //
    // 4,8 MHz / 16 = 300 kHz
    // ============================================================

    decimador #(
        .R(R)
    ) u_decimador (
        .clk   (clk),
        .rst   (rst),
        .count (dec_count),
        .valid (dec_valid)
    );


    // ============================================================
    // 4 COMBS
    //
    // A entrada dos combs é a saída do quarto integrador.
    // Os combs somente atualizam quando dec_valid = 1.
    // ============================================================

    cic_combs #(
        .BITS(BITS)
    ) u_combs (
        .clk       (clk),
        .rst       (rst),
        .valid_in  (dec_valid),
        .x_in      (int4),
        .y_out     (y_out),
        .valid_out (valid_out)
    );

endmodule
