`timescale 1ns/1ps

module cic_integradores #(
    parameter int BITS = 17
)(
    input  logic clk,
    input  logic rst,

    input  logic signed [BITS-1:0] x_in,

    output logic signed [BITS-1:0] int1,
    output logic signed [BITS-1:0] int2,
    output logic signed [BITS-1:0] int3,
    output logic signed [BITS-1:0] int4
);

    logic signed [BITS-1:0] next_int1;
    logic signed [BITS-1:0] next_int2;
    logic signed [BITS-1:0] next_int3;
    logic signed [BITS-1:0] next_int4;

    // Próximos estados dos quatro integradores.
    // A ordem reproduz exatamente o Golden Model Python.
    always_comb begin

        next_int1 = int1 + x_in;

        next_int2 = int2 + next_int1;

        next_int3 = int3 + next_int2;

        next_int4 = int4 + next_int3;

    end


    // Registradores dos estados
    always_ff @(posedge clk) begin

        if (rst) begin

            int1 <= '0;
            int2 <= '0;
            int3 <= '0;
            int4 <= '0;

        end
        else begin

            int1 <= next_int1;
            int2 <= next_int2;
            int3 <= next_int3;
            int4 <= next_int4;

        end

    end

endmodule
