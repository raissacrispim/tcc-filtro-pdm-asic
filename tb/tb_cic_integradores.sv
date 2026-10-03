`timescale 1ns/1ps

module tb_cic_integradores;

    parameter int BITS = 17;

    logic clk;
    logic rst;

    logic signed [BITS-1:0] x_in;

    logic signed [BITS-1:0] int1;
    logic signed [BITS-1:0] int2;
    logic signed [BITS-1:0] int3;
    logic signed [BITS-1:0] int4;


    // ------------------------------------------------
    // Instância do circuito que queremos testar
    // ------------------------------------------------

    cic_integradores #(
        .BITS(BITS)
    ) dut (
        .clk  (clk),
        .rst  (rst),
        .x_in (x_in),
        .int1 (int1),
        .int2 (int2),
        .int3 (int3),
        .int4 (int4)
    );


    // ------------------------------------------------
    // Clock
    // ------------------------------------------------

    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    // ------------------------------------------------
    // Estímulos
    // ------------------------------------------------

    initial begin

        rst  = 1;
        x_in = 0;

        #12;

        rst  = 0;
        x_in = 1;

        // Mantemos +1 por vários ciclos
        #60;

        // Depois aplicamos -1
        x_in = -1;

        #60;

        $finish;
    end


    // ------------------------------------------------
    // Exibição no terminal
    // ------------------------------------------------

    initial begin

        $monitor(
            "tempo=%0t | rst=%0d | x=%0d | I1=%0d | I2=%0d | I3=%0d | I4=%0d",
            $time, rst, x_in, int1, int2, int3, int4
        );

    end


    // ------------------------------------------------
    // Waveform para o Verdi
    // ------------------------------------------------

    initial begin

        $fsdbDumpfile("cic_integradores.fsdb");
        $fsdbDumpvars(0, tb_cic_integradores);

    end

endmodule
