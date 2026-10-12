`timescale 1ns/1ps

module fir #(
    parameter int BITS_IN   = 17,
    parameter int BITS_COEF = 16,
    parameter int BITS_ACC  = 34,
    parameter int BITS_OUT  = 19,
    parameter int TAPS      = 65,
    parameter int FRAC      = 15
)(
    input  logic                         clk,
    input  logic                         rst,
    input  logic                         valid_in,

    input  logic signed [BITS_IN-1:0]    x_in,

    output logic                         valid_out,
    output logic signed [BITS_OUT-1:0]   y_out
);


    // ========================================================
    // LINHA DE ATRASOS
    //
    // delay[0]  = x[n]
    // delay[1]  = x[n-1]
    // ...
    // delay[64] = x[n-64]
    // ========================================================

    logic signed [BITS_IN-1:0] delay [0:TAPS-1];


    // ========================================================
    // COEFICIENTES FIR Q1.15
    // ========================================================

    logic signed [BITS_COEF-1:0] coef [0:TAPS-1];


    // ========================================================
    // VARIÁVEIS AUXILIARES
    // ========================================================

    integer i;

    logic signed [63:0] acc_temp;
    logic signed [63:0] produto_temp;
    logic signed [63:0] acc_sat;
    logic signed [63:0] arredondado;


    // ========================================================
    // COEFICIENTES
    // ========================================================

    initial begin

        coef[ 0] = -16'sd6;
        coef[ 1] = -16'sd2;
        coef[ 2] =  16'sd14;
        coef[ 3] = -16'sd11;
        coef[ 4] = -16'sd22;
        coef[ 5] =  16'sd43;
        coef[ 6] = -16'sd4;
        coef[ 7] = -16'sd80;
        coef[ 8] =  16'sd82;
        coef[ 9] =  16'sd56;
        coef[10] = -16'sd196;
        coef[11] =  16'sd81;
        coef[12] =  16'sd218;
        coef[13] = -16'sd330;
        coef[14] = -16'sd28;
        coef[15] =  16'sd515;
        coef[16] = -16'sd404;
        coef[17] = -16'sd389;
        coef[18] =  16'sd869;
        coef[19] = -16'sd207;
        coef[20] = -16'sd1010;
        coef[21] =  16'sd1065;
        coef[22] =  16'sd394;
        coef[23] = -16'sd1849;
        coef[24] =  16'sd920;
        coef[25] =  16'sd1915;
        coef[26] = -16'sd2661;
        coef[27] = -16'sd709;
        coef[28] =  16'sd4553;
        coef[29] = -16'sd2307;
        coef[30] = -16'sd6823;
        coef[31] =  16'sd10412;
        coef[32] =  16'sd24614;
        coef[33] =  16'sd10412;
        coef[34] = -16'sd6823;
        coef[35] = -16'sd2307;
        coef[36] =  16'sd4553;
        coef[37] = -16'sd709;
        coef[38] = -16'sd2661;
        coef[39] =  16'sd1915;
        coef[40] =  16'sd920;
        coef[41] = -16'sd1849;
        coef[42] =  16'sd394;
        coef[43] =  16'sd1065;
        coef[44] = -16'sd1010;
        coef[45] = -16'sd207;
        coef[46] =  16'sd869;
        coef[47] = -16'sd389;
        coef[48] = -16'sd404;
        coef[49] =  16'sd515;
        coef[50] = -16'sd28;
        coef[51] = -16'sd330;
        coef[52] =  16'sd218;
        coef[53] =  16'sd81;
        coef[54] = -16'sd196;
        coef[55] =  16'sd56;
        coef[56] =  16'sd82;
        coef[57] = -16'sd80;
        coef[58] = -16'sd4;
        coef[59] =  16'sd43;
        coef[60] = -16'sd22;
        coef[61] = -16'sd11;
        coef[62] =  16'sd14;
        coef[63] = -16'sd2;
        coef[64] = -16'sd6;

    end


    // ========================================================
    // FIR
    // ========================================================

    always_ff @(posedge clk) begin

        if (rst) begin

            for (i = 0; i < TAPS; i = i + 1)
                delay[i] <= '0;

            y_out    <= '0;
            valid_out <= 1'b0;

        end
        else begin

            valid_out <= 1'b0;


            if (valid_in) begin

                // ------------------------------------------------
                // Calcula o FIR usando a amostra nova x_in
                // como x[n].
                //
                // Os demais valores vêm da linha de atraso:
                //
                // delay[0] = x[n-1]
                // delay[1] = x[n-2]
                // ...
                // ------------------------------------------------

                acc_temp = 64'sd0;


                // Tap k = 0
                produto_temp =
                    $signed(x_in)
                    *
                    $signed(coef[0]);

                acc_temp =
                    acc_temp
                    +
                    produto_temp;


                // Taps k = 1 ... 64
                for (i = 1; i < TAPS; i = i + 1) begin

                    produto_temp =
                        $signed(delay[i-1])
                        *
                        $signed(coef[i]);

                    acc_temp =
                        acc_temp
                        +
                        produto_temp;

                end


                // ------------------------------------------------
                // SATURAÇÃO DO ACUMULADOR PARA 34 BITS
                // Igual a sat_signed(acc, 34) do Python
                // ------------------------------------------------

                if (acc_temp > 64'sd8589934591)

                    acc_sat = 64'sd8589934591;

                else if (acc_temp < -64'sd8589934592)

                    acc_sat = -64'sd8589934592;

                else

                    acc_sat = acc_temp;


                // ------------------------------------------------
                // ARREDONDAMENTO SIMÉTRICO E SHIFT Q15
                //
                // Python:
                //
                // if x >= 0:
                //     (x + 16384) >> 15
                //
                // else:
                //     -(((-x) + 16384) >> 15)
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
                // SATURAÇÃO FINAL PARA 19 BITS
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
