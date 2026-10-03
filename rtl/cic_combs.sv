`timescale 1ns/1ps

module cic_combs #(
    parameter int BITS = 17
)(
    input  logic clk,
    input  logic rst,
    input  logic valid_in,

    input  logic signed [BITS-1:0] x_in,

    output logic signed [BITS-1:0] y_out,
    output logic valid_out
);

    // Saídas intermediárias
    logic signed [BITS-1:0] comb1;
    logic signed [BITS-1:0] comb2;
    logic signed [BITS-1:0] comb3;

    // Valids intermediários
    logic valid1;
    logic valid2;
    logic valid3;


    // ============================================================
    // COMB 1
    // ============================================================

    comb #(
        .BITS(BITS)
    ) u_comb1 (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .x_in(x_in),
        .y_out(comb1),
        .valid_out(valid1)
    );


    // ============================================================
    // COMB 2
    // ============================================================

    comb #(
        .BITS(BITS)
    ) u_comb2 (
        .clk(clk),
        .rst(rst),
        .valid_in(valid1),
        .x_in(comb1),
        .y_out(comb2),
        .valid_out(valid2)
    );


    // ============================================================
    // COMB 3
    // ============================================================

    comb #(
        .BITS(BITS)
    ) u_comb3 (
        .clk(clk),
        .rst(rst),
        .valid_in(valid2),
        .x_in(comb2),
        .y_out(comb3),
        .valid_out(valid3)
    );


    // ============================================================
    // COMB 4
    // ============================================================

    comb #(
        .BITS(BITS)
    ) u_comb4 (
        .clk(clk),
        .rst(rst),
        .valid_in(valid3),
        .x_in(comb3),
        .y_out(y_out),
        .valid_out(valid_out)
    );

endmodule
