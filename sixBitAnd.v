`timescale 1ns/10ps

module sixBitAnd(A,B,C,D,E,F,OUT);
    input A,B,C,D,E,F;
    output OUT;
    wire AB;
    wire CD;
    wire EF;
    wire ABCD;
    and_gate AandB(A,B,AB);
    and_gate CandD(C,D,CD);
    and_gate EandF(E,F,EF);
    and_gate ABandCD(AB,CD,ABCD);
    and_gate ABCDandEF(ABCD,EF,OUT);
endmodule
