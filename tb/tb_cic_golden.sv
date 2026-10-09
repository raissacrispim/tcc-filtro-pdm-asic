`timescale 1ns/1ps

module tb_cic_golden;

    localparam int BITS     = 18;
    localparam int R        = 16;
    localparam int N_INPUT  = 9600;
    localparam int N_GOLDEN = 600;

    localparam real T_CLK = 208.333;

    logic clk;
    logic rst;

    logic signed [BITS-1:0] x_in;
    logic signed [BITS-2:0] y_out;
    logic                   valid_out;

    integer pdm_mem    [0:N_INPUT-1];
    integer golden_mem [0:N_GOLDEN-1];

    integer i;
    integer indice_saida;
    integer erros;

    integer fd_pdm;
    integer fd_golden;
    integer status_leitura;

    string nome_teste;
    string arquivo_pdm;
    string arquivo_golden;


    // ========================================================
    // DUT
    // ========================================================

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


    // ========================================================
    // CLOCK - aproximadamente 4,8 MHz
    // ========================================================

    initial begin

        clk = 1'b0;

        forever begin
            #(T_CLK/2.0);
            clk = ~clk;
        end

    end


    // ========================================================
    // SELEÇÃO E LEITURA DOS VETORES
    //
    // Exemplo:
    //
    // ./simv_cic_golden +TEST=test_02_30k
    //
    // ========================================================

    initial begin

        // Se nenhum teste for informado,
        // utiliza 10 kHz como padrão.

        if (!$value$plusargs("TEST=%s", nome_teste)) begin
            nome_teste = "test_01_10k";
        end


        arquivo_pdm = {
            "../vectors/",
            nome_teste,
            "_input_pdm.txt"
        };

        arquivo_golden = {
            "../vectors/",
            nome_teste,
            "_output_cic_golden.txt"
        };


        $display("");
        $display("Teste selecionado: %s", nome_teste);
        $display("Arquivo PDM      : %s", arquivo_pdm);
        $display("Arquivo Golden   : %s", arquivo_golden);
        $display("");


        // ----------------------------------------------------
        // Entrada PDM
        // ----------------------------------------------------

        fd_pdm = $fopen(
            arquivo_pdm,
            "r"
        );

        if (fd_pdm == 0) begin

            $display(
                "ERRO: nao foi possivel abrir %s",
                arquivo_pdm
            );

            $finish;

        end


        for (i = 0; i < N_INPUT; i = i + 1) begin

            status_leitura = $fscanf(
                fd_pdm,
                "%d",
                pdm_mem[i]
            );

            if (status_leitura != 1) begin

                $display(
                    "ERRO lendo PDM na amostra %0d",
                    i
                );

                $finish;

            end

        end

        $fclose(fd_pdm);


        // ----------------------------------------------------
        // Saída Golden do CIC
        // ----------------------------------------------------

        fd_golden = $fopen(
            arquivo_golden,
            "r"
        );

        if (fd_golden == 0) begin

            $display(
                "ERRO: nao foi possivel abrir %s",
                arquivo_golden
            );

            $finish;

        end


        for (i = 0; i < N_GOLDEN; i = i + 1) begin

            status_leitura = $fscanf(
                fd_golden,
                "%d",
                golden_mem[i]
            );

            if (status_leitura != 1) begin

                $display(
                    "ERRO lendo Golden na amostra %0d",
                    i
                );

                $finish;

            end

        end

        $fclose(fd_golden);


        $display("Vetores carregados corretamente.");
        $display("PDM    : %0d amostras", N_INPUT);
        $display("Golden : %0d amostras", N_GOLDEN);

    end


    // ========================================================
    // MONITOR DA SAÍDA
    // ========================================================

    always @(negedge clk) begin

        if (!rst && valid_out) begin

            if (indice_saida >= N_GOLDEN) begin

                $display(
                    "ERRO: RTL produziu mais de %0d amostras.",
                    N_GOLDEN
                );

                erros = erros + 1;

            end
            else begin

                if ($signed(y_out) !==
                    golden_mem[indice_saida]) begin

                    $display(
                        "ERRO amostra %0d | RTL=%0d | GOLDEN=%0d",
                        indice_saida,
                        $signed(y_out),
                        golden_mem[indice_saida]
                    );

                    erros = erros + 1;

                end

                indice_saida = indice_saida + 1;

            end

        end

    end


    // ========================================================
    // ESTÍMULOS
    // ========================================================

    initial begin

        rst          = 1'b1;
        x_in         = '0;

        indice_saida = 0;
        erros        = 0;


        // Reset
        repeat (5) @(negedge clk);

        rst = 1'b0;


        // ----------------------------------------------------
        // ENVIO DAS 9600 AMOSTRAS
        //
        // Arquivo PDM:
        //
        // 0 -> -1
        // 1 -> +1
        //
        // ----------------------------------------------------

        for (i = 0; i < N_INPUT; i = i + 1) begin

            if (pdm_mem[i] == 0)
                x_in = -18'sd1;
            else
                x_in = 18'sd1;

            @(negedge clk);

        end


        // Aguarda a última saída
        repeat (10) @(negedge clk);


        // ====================================================
        // RESULTADO
        // ====================================================

        $display("");
        $display("============================================");
        $display(" VALIDACAO CIC RTL x GOLDEN MODEL");
        $display("============================================");

        $display(
            "Teste              : %s",
            nome_teste
        );

        $display(
            "Entradas aplicadas : %0d",
            N_INPUT
        );

        $display(
            "Saidas RTL         : %0d",
            indice_saida
        );

        $display(
            "Saidas Golden      : %0d",
            N_GOLDEN
        );

        $display(
            "Erros encontrados  : %0d",
            erros
        );


        if ((erros == 0) &&
            (indice_saida == N_GOLDEN)) begin

            $display("");
            $display("*** TESTE CIC APROVADO ***");

        end
        else begin

            $display("");
            $display("*** TESTE CIC REPROVADO ***");

        end


        $display("============================================");
        $display("");

        $finish;

    end


endmodule
