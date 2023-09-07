module mul_16_16 (
    input   [15:0]  mul_a,
    input   [15:0]  mul_b,
    output  [31:0]  mul_pro
);
//wire 
wire  [31:0]  booth_out_exp_1;
wire  [31:0]  booth_out_exp_2;
wire  [31:0]  booth_out_exp_3;
wire  [31:0]  booth_out_exp_4;
wire  [31:0]  booth_out_exp_5;
wire  [31:0]  booth_out_exp_6;
wire  [31:0]  booth_out_exp_7;
wire  [31:0]  booth_out_exp_8;

booth_top u_booth_top(
    .xin              ( mul_a           ),
    .yin              ( mul_b           ),
    .booth_out_exp_1  ( booth_out_exp_1 ),
    .booth_out_exp_2  ( booth_out_exp_2 ),
    .booth_out_exp_3  ( booth_out_exp_3 ),
    .booth_out_exp_4  ( booth_out_exp_4 ),
    .booth_out_exp_5  ( booth_out_exp_5 ),
    .booth_out_exp_6  ( booth_out_exp_6 ),
    .booth_out_exp_7  ( booth_out_exp_7 ),
    .booth_out_exp_8  ( booth_out_exp_8 )
);

wallace_16_16 u_wallace_16_16(
    .booth_in0    ( booth_out_exp_1    ),
    .booth_in1    ( booth_out_exp_2    ),
    .booth_in2    ( booth_out_exp_3    ),
    .booth_in3    ( booth_out_exp_4    ),
    .booth_in4    ( booth_out_exp_5    ),
    .booth_in5    ( booth_out_exp_6    ),
    .booth_in6    ( booth_out_exp_7    ),
    .booth_in7    ( booth_out_exp_8    ),
    .wallace_sout (  ),
    .wallace_cout (  ),
    .add_out      ( add_out      )
);




endmodule