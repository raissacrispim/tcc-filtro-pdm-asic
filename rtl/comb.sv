`timescale 1ns/1ps

module comb #(
    parameter int BITS = 17
)(
    input  logic clk,
    input  logic rst,
    input  logic valid_in,

    input  logic signed [BITS-1:0] x_in,

    output logic signed [BITS-1:0] y_out,
    output logic valid_out
);

    // Guarda a amostra anterior x[n-1]
    logic signed [BITS-1:0] x_delay;

    always_ff @(posedge clk) begin

        if (rst) begin

            x_delay   <= '0;
            y_out     <= '0;
            valid_out <= 1'b0;

        end
        else begin

            // Por padrão não existe nova saída
            valid_out <= 1'b0;

            // O comb só trabalha quando chega
            // uma nova amostra decimada.
            if (valid_in) begin

                // y[n] = x[n] - x[n-1]
                y_out <= x_in - x_delay;

                // A entrada atual passa a ser
                // a amostra anterior do próximo cálculo.
                x_delay <= x_in;

                valid_out <= 1'b1;

            end

        end

    end

endmodule
