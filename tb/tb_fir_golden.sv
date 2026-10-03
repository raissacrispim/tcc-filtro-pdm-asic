`timescale 1ns/1ps

module tb_fir_golden;

    localparam int BITS_IN   = 17;
    localparam int BITS_OUT  = 19;
    localparam int N_SAMPLES = 600;

    logic clk;
    logic rst;

    logic valid_in;
    logic signed [BITS_IN-1:0] x_in;

    logic valid_out;
    logic signed [BITS_OUT-1:0] y_out;

    logic signed [BITS_IN-1:0]
        input_vector [0:N_SAMPLES-1];

    logic signed [BITS_OUT-1:0]
        golden_vector [0:N_SAMPLES-1];

    integer i;

    integer file_in;
    integer file_golden;

    integer status_in;
    integer status_golden;

    integer temp_in;
    integer temp_golden;

    integer n_input;
    integer n_golden;

    integer output_index;
    integer errors;

    string test_name;
    string input_file;
    string golden_file;


    // ========================================================
    // DUT
    // ========================================================

    fir #(
        .BITS_IN   (17),
        .BITS_COEF (16),
        .BITS_ACC  (34),
        .BITS_OUT  (19),
        .TAPS      (65),
        .FRAC      (15)
    ) dut (
        .clk       (clk),
        .rst       (rst),
        .valid_in  (valid_in),
        .x_in      (x_in),
        .valid_out (valid_out),
        .y_out     (y_out)
    );


    // ========================================================
    // CLOCK 4,8 MHz
    // ========================================================

    initial begin

        clk = 1'b0;

        forever #104.166 clk = ~clk;

    end


    // ========================================================
    // MONITOR
    // ========================================================

    always @(negedge clk) begin

        if (valid_out) begin

            if (output_index >= n_golden) begin

                $display(
                    "ERRO: RTL produziu saida extra: %0d",
                    $signed(y_out)
                );

                errors = errors + 1;

            end
            else begin

                if ($signed(y_out) !==
                    $signed(golden_vector[output_index])) begin

                    $display(
                        "ERRO [%0d]: RTL = %0d | Golden = %0d",
                        output_index,
                        $signed(y_out),
                        $signed(golden_vector[output_index])
                    );

                    errors = errors + 1;

                end

            end

            output_index = output_index + 1;

        end

    end


    // ========================================================
    // TESTE
    // ========================================================

    initial begin

        rst          = 1'b1;
        valid_in     = 1'b0;
        x_in         = '0;

        output_index = 0;
        errors       = 0;

        n_input      = 0;
        n_golden     = 0;


        // ====================================================
        // SELEÇÃO DO TESTE
        //
        // Exemplo:
        //
        // ./simv_fir_golden +TEST=test_02_30k
        // ====================================================

        if (!$value$plusargs("TEST=%s", test_name)) begin

            test_name = "test_01_10k";

        end


        input_file = {
            "../vectors/",
            test_name,
            "_input_fir.txt"
        };

        golden_file = {
            "../vectors/",
            test_name,
            "_output_fir_golden.txt"
        };


        $display("");
        $display("Teste selecionado: %s", test_name);
        $display("Arquivo entrada  : %s", input_file);
        $display("Arquivo Golden   : %s", golden_file);


        // ====================================================
        // CARREGA ENTRADA
        // ====================================================

        file_in = $fopen(input_file, "r");

        if (file_in == 0) begin

            $display(
                "ERRO: nao foi possivel abrir %s",
                input_file
            );

            $finish;

        end


        while (!$feof(file_in) &&
               n_input < N_SAMPLES) begin

            status_in = $fscanf(
                file_in,
                "%d",
                temp_in
            );

            if (status_in == 1) begin

                input_vector[n_input] = temp_in;

                n_input = n_input + 1;

            end

        end

        $fclose(file_in);


        // ====================================================
        // CARREGA GOLDEN
        // ====================================================

        file_golden = $fopen(golden_file, "r");

        if (file_golden == 0) begin

            $display(
                "ERRO: nao foi possivel abrir %s",
                golden_file
            );

            $finish;

        end


        while (!$feof(file_golden) &&
               n_golden < N_SAMPLES) begin

            status_golden = $fscanf(
                file_golden,
                "%d",
                temp_golden
            );

            if (status_golden == 1) begin

                golden_vector[n_golden] = temp_golden;

                n_golden = n_golden + 1;

            end

        end

        $fclose(file_golden);


        $display("");
        $display("Vetores carregados corretamente.");
        $display("Entrada FIR : %0d", n_input);
        $display("Golden FIR  : %0d", n_golden);


        if ((n_input != N_SAMPLES) ||
            (n_golden != N_SAMPLES)) begin

            $display(
                "ERRO: quantidade incorreta de amostras."
            );

            $finish;

        end


        // ====================================================
        // RESET
        // ====================================================

        repeat (5) @(posedge clk);

        rst = 1'b0;


        // ====================================================
        // APLICA AS 600 AMOSTRAS
        //
        // Uma amostra FIR válida a cada 16 clocks.
        // ====================================================

        for (i = 0; i < n_input; i = i + 1) begin

            @(negedge clk);

            x_in     = input_vector[i];
            valid_in = 1'b1;

            @(negedge clk);

            valid_in = 1'b0;

            repeat (14) @(negedge clk);

        end


        // ====================================================
        // AGUARDA FINALIZAÇÃO
        // ====================================================

        repeat (20) @(negedge clk);


        // ====================================================
        // RESULTADO
        // ====================================================

        $display("");
        $display("========================================");
        $display("VALIDACAO FIR RTL x GOLDEN MODEL");
        $display("========================================");

        $display(
            "Teste              : %s",
            test_name
        );

        $display(
            "Entradas aplicadas : %0d",
            n_input
        );

        $display(
            "Saidas RTL         : %0d",
            output_index
        );

        $display(
            "Saidas Golden      : %0d",
            n_golden
        );

        $display(
            "Erros encontrados  : %0d",
            errors
        );


        if ((errors == 0) &&
            (output_index == n_golden)) begin

            $display("");
            $display("*** TESTE FIR APROVADO ***");

        end
        else begin

            $display("");
            $display("*** TESTE FIR REPROVADO ***");

        end

        $display("========================================");
        $display("");

        $finish;

    end

endmodule
