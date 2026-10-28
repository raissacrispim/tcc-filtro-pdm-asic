// ============================================================
// amostra_saida.sv
// Saida do filtro amostrada como o testbench a le
//
// Usado so na simulacao das imagens (imagens/scripts/
// sim_ondas_amostradas.sh), como segundo modulo de topo ao
// lado de tb_filtro_pdm_golden. Nao altera o testbench nem o
// projeto.
//
// Na netlist pos-layout com SDF, os 19 bits de y_out mudam em
// instantes ligeiramente diferentes apos cada borda de clock.
// A forma analogica do Verdi desenha os valores intermediarios
// como picos. O testbench compara y_out na borda de descida do
// clock com valid_out = 1, quando os bits ja estao estaveis;
// y_amostrado guarda esse mesmo valor.
// ============================================================

module amostra_saida;

    logic signed [18:0] y_amostrado = '0;

    always @(negedge tb_filtro_pdm_golden.clk)
        if (tb_filtro_pdm_golden.valid_out)
            y_amostrado <= tb_filtro_pdm_golden.y_out;

    // Depois do $fsdbDumpfile do testbench (tempo 0)
    initial begin
        #1;
        $fsdbDumpvars(0, amostra_saida);
    end

endmodule
