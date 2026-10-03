`timescale 1ns/1ps

module tb_cic;

    localparam int BITS = 17;
    localparam int R    = 16;

    logic clk;
    logic rst;

    logic signed [BITS-1:0] x_in;
    logic signed [BITS-1:0] y_out;

    logic valid_out;


    // ============================================================
    // DUT
    // ============================================================

    cic #(
        .BITS(BITS),
        .R(R)
    ) dut (
        .clk       (clk),
        .rst       (rst),
        .x_in      (x_in),
        .y_out     (y_out),
        .valid_out (valid_out)
    );


    // ============================================================
    // CLOCK
    // ============================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    // ============================================================
    // ESTÍMULOS
    // ============================================================

    integer i;

    initial begin

        rst  = 1;
        x_in = 0;

        repeat(3) @(negedge clk);

        rst = 0;


        // --------------------------------------------------------
        // Primeiro trecho: entrada +1
        // --------------------------------------------------------

        for (i = 0; i < 128; i = i + 1) begin
            @(negedge clk);
            x_in = 17'sd1;
        end


        // --------------------------------------------------------
        // Segundo trecho: entrada -1
        // --------------------------------------------------------

        for (i = 0; i < 128; i = i + 1) begin
            @(negedge clk);
            x_in = -17'sd1;
        end


        // --------------------------------------------------------
        // Terceiro trecho: alternância +1/-1
        // --------------------------------------------------------

        for (i = 0; i < 128; i = i + 1) begin
            @(negedge clk);

            if ((i % 2) == 0)
                x_in = 17'sd1;
            else
                x_in = -17'sd1;
        end


        repeat(100) @(negedge clk);

        $finish;

    end


    // ============================================================
    // MONITOR DA SAÍDA DECIMADA
    // ============================================================

    always @(negedge clk) begin

        if (valid_out) begin

            $display(
                "CIC | tempo=%0t | y_out=%0d",
                $time,
                $signed(y_out)
            );

        end

    end


    // ============================================================
    // WAVEFORM
    // ============================================================

    initial begin

        $fsdbDumpfile("cic.fsdb");
        $fsdbDumpvars(0, tb_cic);

    end

endmodule
