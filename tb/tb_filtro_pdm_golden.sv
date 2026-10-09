`timescale 1ns/1ps

module tb_filtro_pdm_golden;

    localparam int N_PDM = 9600;
    localparam int N_OUT = 600;

    logic clk;
    logic rst;
    logic pdm_in;

    logic signed [18:0] y_out;
    logic               valid_out;

    integer pdm_vector    [0:N_PDM-1];
    integer golden_vector [0:N_OUT-1];

    integer i;

    integer file_pdm;
    integer file_golden;
    integer file_rtl;

    integer status_pdm;
    integer status_golden;

    integer temp_pdm;
    integer temp_golden;

    integer n_pdm;
    integer n_golden;

    integer output_index;
    integer errors;
    integer timeout_count;

    string test_name;
    string pdm_file;
    string golden_file;
    string rtl_file;

    // ========================================================
    // DUMP DE WAVEFORMS PARA O VERDI
    // ========================================================

    initial begin

        $fsdbDumpfile("filtro_pdm.fsdb");

        $fsdbDumpvars(
            0,
            tb_filtro_pdm_golden
        );

    end


    // ========================================================
    // DUT
    // ========================================================

    // Na netlist com DFT existem as portas de scan.
    // Compilar com +define+DFT na simulacao gate-level.
    // Modo funcional: scan_en = 0.
`ifdef DFT
    logic scan_out;
`endif

    filtro_pdm dut (
        .clk       (clk),
        .rst       (rst),
        .pdm_in    (pdm_in),
`ifdef DFT
        .scan_en   (1'b0),
        .scan_in   (1'b0),
        .scan_out  (scan_out),
`endif
        .y_out     (y_out),
        .valid_out (valid_out)
    );


    // ========================================================
    // CLOCK DE 4,8 MHz
    // ========================================================

    initial begin
        clk = 1'b0;
        forever #104.166 clk = ~clk;
    end


    // ========================================================
    // MONITOR DA SAÍDA
    //
    // Compara RTL x Golden e salva a saída RTL.
    // ========================================================

    always @(negedge clk) begin

        if (valid_out) begin

            if (output_index < n_golden) begin

                // Salva a amostra produzida pelo RTL
                $fdisplay(
                    file_rtl,
                    "%0d",
                    $signed(y_out)
                );

                // Compara com o Golden Model
                if (
                    $signed(y_out)
                    !==
                    golden_vector[output_index]
                ) begin

                    $display(
                        "ERRO [%0d]: RTL = %0d | Golden = %0d",
                        output_index,
                        $signed(y_out),
                        golden_vector[output_index]
                    );

                    errors = errors + 1;

                end

            end
            else begin

                $display(
                    "ERRO: RTL produziu saida extra: %0d",
                    $signed(y_out)
                );

                errors = errors + 1;

            end

            output_index = output_index + 1;

        end

    end


    // ========================================================
    // TESTE PRINCIPAL
    // ========================================================

    initial begin

        // Inicialização
        rst    = 1'b1;
        pdm_in = 1'b0;

        n_pdm       = 0;
        n_golden    = 0;
        output_index = 0;
        errors       = 0;
        timeout_count = 0;


        // ====================================================
        // SELEÇÃO DO TESTE
        // ====================================================

        if (!$value$plusargs("TEST=%s", test_name)) begin
            test_name = "test_01_10k";
        end


        // ====================================================
        // NOMES DOS ARQUIVOS
        // ====================================================

        pdm_file = {
            "../vectors/",
            test_name,
            "_input_pdm.txt"
        };

        golden_file = {
            "../vectors/",
            test_name,
            "_output_golden.txt"
        };

        rtl_file = {
            "../vectors/",
            test_name,
            "_output_rtl.txt"
        };


        $display("");

        $display(
            "Teste selecionado: %s",
            test_name
        );

        $display(
            "Arquivo PDM    : %s",
            pdm_file
        );

        $display(
            "Arquivo Golden : %s",
            golden_file
        );

        $display(
            "Arquivo RTL    : %s",
            rtl_file
        );


        // ====================================================
        // LEITURA DO VETOR PDM
        // ====================================================

        file_pdm = $fopen(
            pdm_file,
            "r"
        );

        if (file_pdm == 0) begin

            $display(
                "ERRO: nao foi possivel abrir %s",
                pdm_file
            );

            $finish;

        end


        while (
            !$feof(file_pdm)
            &&
            n_pdm < N_PDM
        ) begin

            status_pdm = $fscanf(
                file_pdm,
                "%d",
                temp_pdm
            );

            if (status_pdm == 1) begin

                pdm_vector[n_pdm] = temp_pdm;
                n_pdm = n_pdm + 1;

            end

        end

        $fclose(file_pdm);


        // ====================================================
        // LEITURA DO GOLDEN MODEL
        // ====================================================

        file_golden = $fopen(
            golden_file,
            "r"
        );

        if (file_golden == 0) begin

            $display(
                "ERRO: nao foi possivel abrir %s",
                golden_file
            );

            $finish;

        end


        while (
            !$feof(file_golden)
            &&
            n_golden < N_OUT
        ) begin

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


        // ====================================================
        // VERIFICAÇÃO DOS VETORES
        // ====================================================

        $display("");

        $display(
            "Vetores carregados corretamente."
        );

        $display(
            "PDM    : %0d",
            n_pdm
        );

        $display(
            "Golden : %0d",
            n_golden
        );


        if (
            (n_pdm != N_PDM)
            ||
            (n_golden != N_OUT)
        ) begin

            $display(
                "ERRO: quantidade incorreta de amostras."
            );

            $finish;

        end


        // ====================================================
        // CRIA ARQUIVO PARA A SAÍDA RTL
        // ====================================================

        file_rtl = $fopen(
            rtl_file,
            "w"
        );

        if (file_rtl == 0) begin

            $display(
                "ERRO: nao foi possivel criar %s",
                rtl_file
            );

            $finish;

        end


        // ====================================================
        // RESET
        //
        // Primeira amostra deve estar preparada antes do
        // primeiro posedge ativo.
        // ====================================================

        repeat (5) @(posedge clk);

        @(negedge clk);

        pdm_in = pdm_vector[0];

        rst = 1'b0;


        // ====================================================
        // APLICAÇÃO DAS DEMAIS AMOSTRAS PDM
        // ====================================================

        for (
            i = 1;
            i < n_pdm;
            i = i + 1
        ) begin

            @(negedge clk);

            pdm_in = pdm_vector[i];

        end


        // ====================================================
        // ESPERA PELA LATÊNCIA FINAL CIC -> FIR
        // ====================================================

        timeout_count = 0;

        while (
            (output_index < n_golden)
            &&
            (timeout_count < 20)
        ) begin

            @(negedge clk);

            timeout_count = timeout_count + 1;

        end


        // ====================================================
        // VERIFICAÇÃO DE TIMEOUT
        // ====================================================

        if (output_index < n_golden) begin

            $display("");

            $display(
                "ERRO: timeout esperando todas as saidas."
            );

            $display(
                "Saidas observadas ate o timeout: %0d",
                output_index
            );

        end


        // ====================================================
        // FECHA O ARQUIVO RTL
        // ====================================================

        $fclose(file_rtl);


        // ====================================================
        // RESULTADO FINAL
        // ====================================================

        $display("");

        $display(
            "========================================"
        );

        $display(
            "VALIDACAO FILTRO COMPLETO RTL x GOLDEN"
        );

        $display(
            "========================================"
        );

        $display(
            "Teste              : %s",
            test_name
        );

        $display(
            "Entradas PDM       : %0d",
            n_pdm
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

        $display(
            "Arquivo RTL        : %s",
            rtl_file
        );


        if (
            (errors == 0)
            &&
            (output_index == n_golden)
        ) begin

            $display("");

            $display(
                "*** FILTRO COMPLETO APROVADO ***"
            );

        end
        else begin

            $display("");

            $display(
                "*** FILTRO COMPLETO REPROVADO ***"
            );

        end


        $display(
            "========================================"
        );

        $display("");

        $finish;

    end

endmodule
