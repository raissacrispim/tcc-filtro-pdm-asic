`timescale 1ns/1ps

module decimador #(
    parameter int R = 16
)(
    input  logic clk,
    input  logic rst,

    output logic [$clog2(R)-1:0] count,
    output logic                  valid
);

    always_ff @(posedge clk) begin
        if (rst) begin
            count <= '0;
            valid <= 1'b0;
        end
        else begin
            if (count == R-1) begin
                count <= '0;
                valid <= 1'b1;
            end
            else begin
                count <= count + 1'b1;
                valid <= 1'b0;
            end
        end
    end

endmodule
