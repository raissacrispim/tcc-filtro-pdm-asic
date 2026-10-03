`timescale 1ns/1ps

module tb_integrador;

    localparam BITS = 17;

    logic clk;
    logic rst;
    logic signed [BITS-1:0] x_in;
    logic signed [BITS-1:0] y_out;

    integrador #(
        .BITS(BITS)
    ) dut (
        .clk   (clk),
        .rst   (rst),
        .x_in  (x_in),
        .y_out (y_out)
    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Estímulos
    initial begin

        rst  = 1;
        x_in = 0;

        #12;
        rst = 0;

        x_in = 1;
        #10;

        x_in = 1;
        #10;

        x_in = -1;
        #10;

        x_in = 1;
        #10;

        x_in = -1;
        #10;

        $finish;
    end

    // Mostra os valores durante a simulação
    initial begin
        $monitor(
            "tempo=%0t | rst=%0b | x=%0d | y=%0d",
            $time, rst, x_in, y_out
        );
    end

    initial begin
        $fsdbDumpfile("integrador.fsdb");
        $fsdbDumpvars(0, tb_integrador);
    end

endmodule
