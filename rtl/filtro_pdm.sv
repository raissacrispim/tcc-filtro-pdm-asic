`timescale 1ns/1ps

module filtro_pdm #(
    parameter int BITS_CIC = 18,
    parameter int R        = 16
)(
    input  logic                    clk,
    input  logic                    rst,

    // Entrada física PDM: 0 ou 1
    input  logic                    pdm_in,

    // Saída final do filtro
    output logic signed [18:0]       y_out,
    output logic                    valid_out
);

    // ========================================================
    // MAPEAMENTO PDM
    //
    // Golden Model:
    //
    //     0 -> -1
    //     1 -> +1
    //
    // O CIC trabalha com signed de 18 bits.
    // ========================================================

    logic signed [BITS_CIC-1:0] pdm_bipolar;

    always_comb begin

        if (pdm_in == 1'b1)
            pdm_bipolar = 18'sd1;
        else
            pdm_bipolar = -18'sd1;

    end


    // ========================================================
    // INTERFACE CIC -> FIR
    // ========================================================

    logic signed [BITS_CIC-2:0] cic_out;
    logic                       cic_valid;


    // ========================================================
    // CIC
    //
    // 4,8 MHz -> 300 kHz
    // integradores e combs com 18 bits
    // saída signed de 17 bits (LSB sempre zero descartado)
    // ========================================================

    cic #(
        .BITS (BITS_CIC),
        .R    (R)
    ) u_cic (
        .clk       (clk),
        .rst       (rst),
        .x_in      (pdm_bipolar),
        .y_out     (cic_out),
        .valid_out (cic_valid)
    );


    // ========================================================
    // FIR
    //
    // Entrada:
    //     17 bits
    //     nova amostra quando cic_valid = 1
    //
    // Saída:
    //     19 bits
    // ========================================================

    fir #(
        .BITS_IN   (BITS_CIC-1),
        .BITS_COEF (16),
        .BITS_ACC  (34),
        .BITS_OUT  (19),
        .TAPS      (65),
        .FRAC      (15)
    ) u_fir (
        .clk       (clk),
        .rst       (rst),
        .valid_in  (cic_valid),
        .x_in      (cic_out),
        .valid_out (valid_out),
        .y_out     (y_out)
    );

endmodule
