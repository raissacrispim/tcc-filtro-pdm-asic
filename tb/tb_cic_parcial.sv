`timescale 1ns/1ps

module tb_cic_parcial;

    localparam int BITS = 17;

    logic clk;
    logic rst;

    logic signed [BITS-1:0] x_in;

    logic signed [BITS-1:0] int1;
    logic signed [BITS-1:0] int2;
    logic signed [BITS-1:0] int3;
    logic signed [BITS-1:0] int4;

    logic signed [BITS-1:0] dec_out;
    logic valid_out;
    logic [3:0] count;

    cic_parcial #(
        .BITS(BITS),
        .R(16)
    ) dut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),

        .int1(int1),
        .int2(int2),
        .int3(int3),
        .int4(int4),

        .dec_out(dec_out),
        .valid_out(valid_out),
        .count(count)
    );

    // Clock de simulação
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Estímulo
    initial begin
        rst  = 1;
        x_in = 0;

        #12;
        rst = 0;

        // Entrada constante +1
        x_in = 17'sd1;

        // Tempo suficiente para várias decimações
        #550;

        $finish;
    end

    // Mostra apenas as amostras decimadas
    always @(negedge clk) begin
        if (valid_out) begin
            $display(
                "DECIMADA | tempo=%0t | count=%0d | int4=%0d | dec_out=%0d",
                $time,
                count,
                $signed(int4),
                $signed(dec_out)
            );
        end
    end

    initial begin
        $fsdbDumpfile("cic_parcial.fsdb");
        $fsdbDumpvars(0, tb_cic_parcial);
    end

endmodule
