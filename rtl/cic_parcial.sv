`timescale 1ns/1ps

module cic_parcial #(
    parameter int BITS = 17,
    parameter int R    = 16
)(
    input  logic clk,
    input  logic rst,
    input  logic signed [BITS-1:0] x_in,

    output logic signed [BITS-1:0] int1,
    output logic signed [BITS-1:0] int2,
    output logic signed [BITS-1:0] int3,
    output logic signed [BITS-1:0] int4,

    output logic signed [BITS-1:0] dec_out,
    output logic valid_out,
    output logic [$clog2(R)-1:0] count
);

    // ============================================================
    // Valores seguintes dos quatro integradores
    // ============================================================

    logic signed [BITS-1:0] int1_next;
    logic signed [BITS-1:0] int2_next;
    logic signed [BITS-1:0] int3_next;
    logic signed [BITS-1:0] int4_next;


    // ============================================================
    // Lógica combinacional dos integradores
    //
    // Implementa:
    //
    // int1_next = int1 + x
    // int2_next = int2 + int1_next
    // int3_next = int3 + int2_next
    // int4_next = int4 + int3_next
    //
    // Isso reproduz a cascata utilizada no Golden Model.
    // ============================================================

    always_comb begin

        int1_next = int1 + x_in;
        int2_next = int2 + int1_next;
        int3_next = int3 + int2_next;
        int4_next = int4 + int3_next;

    end


    // ============================================================
    // Registradores dos integradores + decimador R = 16
    // ============================================================

    always_ff @(posedge clk) begin

        if (rst) begin

            // Zera os quatro integradores
            int1 <= '0;
            int2 <= '0;
            int3 <= '0;
            int4 <= '0;

            // Zera o contador do decimador
            count <= '0;

            // Saída decimada
            dec_out <= '0;

            // Indicação de nova amostra decimada
            valid_out <= 1'b0;

        end
        else begin

            // ----------------------------------------------------
            // Atualização dos quatro integradores
            // ----------------------------------------------------

            int1 <= int1_next;
            int2 <= int2_next;
            int3 <= int3_next;
            int4 <= int4_next;


            // ----------------------------------------------------
            // Seleção da amostra decimada
            //
            // count = 0 seleciona:
            //
            // 0, 16, 32, 48, ...
            //
            // correspondendo ao Python:
            //
            // int4[::16]
            // ----------------------------------------------------

            if (count == 0) begin

                dec_out   <= int4_next;
                valid_out <= 1'b1;

            end
            else begin

                valid_out <= 1'b0;

            end


            // ----------------------------------------------------
            // Contador módulo R
            //
            // Para R = 16:
            //
            // 0,1,2,...,14,15,0,1,...
            // ----------------------------------------------------

            if (count == R-1) begin

                count <= '0;

            end
            else begin

                count <= count + 1'b1;

            end

        end

    end

endmodule
