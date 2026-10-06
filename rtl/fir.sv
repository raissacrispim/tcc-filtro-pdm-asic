`timescale 1ns/1ps

module fir #(
    parameter int BITS_IN   = 17,
    parameter int BITS_COEF = 16,
    parameter int BITS_ACC  = 34,
    parameter int BITS_OUT  = 19,
    parameter int TAPS      = 65,
    parameter int FRAC      = 15
)(
    input  logic                      clk,
    input  logic                      rst,
    input  logic                      valid_in,
    input  logic signed [BITS_IN-1:0] x_in,

    output logic                      valid_out,
    output logic signed [BITS_OUT-1:0] y_out
);


    // ========================================================
    // LINHA DE ATRASOS
    //
    // Durante o calculo:
    //
    // x_in      = x[n]
    // delay[0]  = x[n-1]
    // delay[1]  = x[n-2]
    // ...
    // delay[63] = x[n-64]
    //
    // O vetor possui TAPS elementos para manter a estrutura
    // parametrizavel, embora no calculo sejam utilizados
    // delay[0] ate delay[TAPS-2].
    // ========================================================

    logic signed [BITS_IN-1:0] delay [0:TAPS-1];


    // ========================================================
    // VARIAVEIS AUXILIARES
    // ========================================================

    integer i;

    logic signed [63:0] acc_temp;
    logic signed [63:0] produto_temp;
    logic signed [63:0] acc_sat;
    logic signed [63:0] arredondado;


    // ========================================================
    // COEFICIENTES FIR Q1.15
    //
    // Os coeficientes sao constantes do projeto.
    //
    // Em vez de utilizar um bloco "initial", eles sao
    // representados por uma funcao combinacional. Isso permite
    // que o Design Compiler os trate diretamente como
    // constantes durante a sintese.
    // ========================================================

    function automatic logic signed [BITS_COEF-1:0] coef;
        input integer idx;

        begin
            case (idx)

                 0: coef = -16'sd6;
                 1: coef = -16'sd2;
                 2: coef =  16'sd14;
                 3: coef = -16'sd11;
                 4: coef = -16'sd22;
                 5: coef =  16'sd43;
                 6: coef = -16'sd4;
                 7: coef = -16'sd80;
                 8: coef =  16'sd82;
                 9: coef =  16'sd56;

                10: coef = -16'sd196;
                11: coef =  16'sd81;
                12: coef =  16'sd218;
                13: coef = -16'sd330;
                14: coef = -16'sd28;
                15: coef =  16'sd515;
                16: coef = -16'sd404;
                17: coef = -16'sd389;
                18: coef =  16'sd869;
                19: coef = -16'sd207;

                20: coef = -16'sd1010;
                21: coef =  16'sd1065;
                22: coef =  16'sd394;
                23: coef = -16'sd1849;
                24: coef =  16'sd920;
                25: coef =  16'sd1915;
                26: coef = -16'sd2661;
                27: coef = -16'sd709;
                28: coef =  16'sd4553;
                29: coef = -16'sd2307;

                30: coef = -16'sd6823;
                31: coef =  16'sd10412;
                32: coef =  16'sd24614;
                33: coef =  16'sd10412;
                34: coef = -16'sd6823;
                35: coef = -16'sd2307;
                36: coef =  16'sd4553;
                37: coef = -16'sd709;
                38: coef = -16'sd2661;
                39: coef =  16'sd1915;

                40: coef =  16'sd920;
                41: coef = -16'sd1849;
                42: coef =  16'sd394;
                43: coef =  16'sd1065;
                44: coef = -16'sd1010;
                45: coef = -16'sd207;
                46: coef =  16'sd869;
                47: coef = -16'sd389;
                48: coef = -16'sd404;
                49: coef =  16'sd515;

                50: coef = -16'sd28;
                51: coef = -16'sd330;
                52: coef =  16'sd218;
                53: coef =  16'sd81;
                54: coef = -16'sd196;
                55: coef =  16'sd56;
                56: coef =  16'sd82;
                57: coef = -16'sd80;
                58: coef = -16'sd4;
                59: coef =  16'sd43;

                60: coef = -16'sd22;
                61: coef = -16'sd11;
                62: coef =  16'sd14;
                63: coef = -16'sd2;
                64: coef = -16'sd6;

                default: coef = '0;

            endcase
        end
    endfunction


    // ========================================================
    // FIR
    // ========================================================

    always_ff @(posedge clk) begin

        if (rst) begin

            for (i = 0; i < TAPS; i = i + 1)
                delay[i] <= '0;

            y_out     <= '0;
            valid_out <= 1'b0;

        end
        else begin

            valid_out <= 1'b0;


            if (valid_in) begin

                // ------------------------------------------------
                // Calcula o FIR usando a amostra nova x_in
                // como x[n].
                //
                // Os demais valores vem da linha de atraso:
                //
                // delay[0] = x[n-1]
                // delay[1] = x[n-2]
                // ...
                // ------------------------------------------------

                acc_temp = 64'sd0;


                // ------------------------------------------------
                // Tap k = 0
                // ------------------------------------------------

                produto_temp =
                    $signed(x_in)
                    *
                    $signed(coef(0));

                acc_temp =
                    acc_temp
                    +
                    produto_temp;


                // ------------------------------------------------
                // Taps k = 1 ... 64
                // ------------------------------------------------

                for (i = 1; i < TAPS; i = i + 1) begin

                    produto_temp =
                        $signed(delay[i-1])
                        *
                        $signed(coef(i));

                    acc_temp =
                        acc_temp
                        +
                        produto_temp;

                end


                // ------------------------------------------------
                // SATURACAO DO ACUMULADOR PARA 34 BITS
                //
                // Equivalente a:
                //
                // sat_signed(acc, 34)
                //
                // do Golden Model em Python.
                //
                // Faixa:
                //
                // -2^33 ate 2^33 - 1
                //
                // -8589934592 ate 8589934591
                // ------------------------------------------------

                if (acc_temp > 64'sd8589934591)

                    acc_sat = 64'sd8589934591;

                else if (acc_temp < -64'sd8589934592)

                    acc_sat = -64'sd8589934592;

                else

                    acc_sat = acc_temp;


                // ------------------------------------------------
                // ARREDONDAMENTO SIMETRICO E SHIFT Q15
                //
                // Equivalente ao Python:
                //
                // if x >= 0:
                //     (x + 16384) >> 15
                // else:
                //     -(((-x) + 16384) >> 15)
                //
                // 16384 = 2^(15-1)
                // ------------------------------------------------

                if (acc_sat >= 0) begin

                    arredondado =
                        (acc_sat + 64'sd16384)
                        >>> FRAC;

                end
                else begin

                    arredondado =
                        -(
                            ((-acc_sat) + 64'sd16384)
                            >>> FRAC
                        );

                end


                // ------------------------------------------------
                // SATURACAO FINAL PARA 19 BITS
                //
                // Faixa signed de 19 bits:
                //
                // -262144 ate 262143
                // ------------------------------------------------

                if (arredondado > 64'sd262143)

                    y_out <= 19'sd262143;

                else if (arredondado < -64'sd262144)

                    y_out <= -19'sd262144;

                else

                    y_out <= arredondado[BITS_OUT-1:0];


                valid_out <= 1'b1;


                // ------------------------------------------------
                // ATUALIZA LINHA DE ATRASOS
                // ------------------------------------------------

                for (i = TAPS-1; i > 0; i = i - 1)
                    delay[i] <= delay[i-1];

                delay[0] <= x_in;

            end

        end

    end

endmodule
