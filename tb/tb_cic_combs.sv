`timescale 1ns/1ps

module tb_cic_combs;

    localparam int BITS = 17;

    logic clk;
    logic rst;
    logic valid_in;

    logic signed [BITS-1:0] x_in;

    logic signed [BITS-1:0] y_out;
    logic valid_out;


    // ============================================================
    // DUT
    // ============================================================

    cic_combs #(
        .BITS(BITS)
    ) dut (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .x_in(x_in),
        .y_out(y_out),
        .valid_out(valid_out)
    );


    // ============================================================
    // Clock
    // ============================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    // ============================================================
    // Estímulos
    // ============================================================

    initial begin

        rst      = 1;
        valid_in = 0;
        x_in     = 0;

        #12;
        rst = 0;

        // Enviamos uma sequência simples
        @(negedge clk);
        x_in     = 17'sd1;
        valid_in = 1;

        @(negedge clk);
        x_in = 17'sd5;

        @(negedge clk);
        x_in = 17'sd15;

        @(negedge clk);
        x_in = 17'sd35;

        @(negedge clk);
        x_in = 17'sd70;

        @(negedge clk);
        x_in = 17'sd126;

        @(negedge clk);
        x_in = 17'sd210;

        @(negedge clk);
        x_in = 17'sd330;

        @(negedge clk);
        valid_in = 0;
        x_in     = 0;

        repeat(10) @(negedge clk);

        $finish;

    end


    // ============================================================
    // Monitor
    // ============================================================

    always @(negedge clk) begin

        if (valid_out) begin

            $display(
                "COMBS | tempo=%0t | y_out=%0d",
                $time,
                $signed(y_out)
            );

        end

    end


    // ============================================================
    // Waveform
    // ============================================================

    initial begin

        $fsdbDumpfile("cic_combs.fsdb");
        $fsdbDumpvars(0, tb_cic_combs);

    end

endmodule
