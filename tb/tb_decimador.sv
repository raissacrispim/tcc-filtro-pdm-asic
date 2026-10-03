`timescale 1ns/1ps

module tb_decimador;

    logic clk;
    logic rst;

    logic [3:0] count;
    logic valid;

    decimador #(
        .R(16)
    ) dut (
        .clk   (clk),
        .rst   (rst),
        .count (count),
        .valid (valid)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;

        #12;
        rst = 0;

        // Tempo suficiente para observar
        // mais de dois períodos de decimação.
        #350;

        $finish;
    end

    initial begin
        $monitor(
            "tempo=%0t | count=%0d | valid=%0d",
            $time, count, valid
        );
    end

    initial begin
        $fsdbDumpfile("decimador.fsdb");
        $fsdbDumpvars(0, tb_decimador);
    end

endmodule
