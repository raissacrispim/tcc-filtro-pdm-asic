module mini (input a, output [1:0] y, output z);
  NBUFFX2_RVT u0 (.A(a), .Y(y[0]));
  NBUFFX2_RVT u1 (.A(a), .Y(y[1]));
  NBUFFX2_RVT u2 (.A(a), .Y(z));
endmodule
