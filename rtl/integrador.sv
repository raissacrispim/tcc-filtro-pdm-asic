`timescale 1ns/1ps

module integrador #(
    parameter BITS = 17
)(
    input  logic                    clk,
    input  logic                    rst,
    input  logic signed [BITS-1:0]  x_in,
    output logic signed [BITS-1:0]  y_out
);

    always_ff @(posedge clk) begin
        if (rst)
            y_out <= '0;
        else
            y_out <= y_out + x_in;
    end

endmodule
