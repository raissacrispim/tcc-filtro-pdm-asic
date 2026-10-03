`timescale 1ns/1ps

module tb_comb;

    localparam int BITS = 17;

    logic clk;
    logic rst;
    logic valid_in;

    logic signed [BITS-1:0] x_in;

    logic signed [BITS-1:0] y_out;
    logic valid_out;


    // ============================================================
    // Instância do Comb
    // ============================================================

    comb #(
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

        // Primeira amostra
        @(negedge clk);
        x_in     = 17'sd10;
        valid_in = 1;

        @(negedge clk);
        valid_in = 0;

        // Espera alguns clocks
        repeat(2) @(negedge clk);

        // Segunda amostra
        x_in     = 17'sd15;
        valid_in = 1;

        @(negedge clk);
        valid_in = 0;

        repeat(2) @(negedge clk);

        // Terceira amostra
        x_in     = 17'sd21;
        valid_in = 1;

        @(negedge clk);
        valid_in = 0;

        repeat(2) @(negedge clk);

        // Quarta amostra
        x_in     = 17'sd28;
        valid_in = 1;

        @(negedge clk);
        valid_in = 0;

        repeat(3) @(negedge clk);

        $finish;

    end


    // ============================================================
    // Mostra somente as saídas válidas
    // ============================================================

    always @(negedge clk) begin

        if (valid_out) begin

            $display(
                "COMB | tempo=%0t | x_in=%0d | y_out=%0d",
                $time,
                $signed(x_in),
                $signed(y_out)
            );

        end

    end


    // ============================================================
    // Arquivo de waveform
    // ============================================================

    initial begin

        $fsdbDumpfile("comb.fsdb");
        $fsdbDumpvars(0, tb_comb);

    end

endmodule
