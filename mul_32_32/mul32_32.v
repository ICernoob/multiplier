module mul_32_32 (
    input   [31:0]  mul_a,
    input   [31:0]  mul_b,
    output  [63:0]  mul_pro
);
//wire 
wire  [63:0]  booth_out_exp_1;
wire  [63:0]  booth_out_exp_2;
wire  [63:0]  booth_out_exp_3;
wire  [63:0]  booth_out_exp_4;
wire  [63:0]  booth_out_exp_5;
wire  [63:0]  booth_out_exp_6;
wire  [63:0]  booth_out_exp_7;
wire  [63:0]  booth_out_exp_8;
wire  [63:0]  booth_out_exp_9;
wire  [63:0]  booth_out_exp_10;
wire  [63:0]  booth_out_exp_11;
wire  [63:0]  booth_out_exp_12;
wire  [63:0]  booth_out_exp_13;
wire  [63:0]  booth_out_exp_14;
wire  [63:0]  booth_out_exp_15;
wire  [63:0]  booth_out_exp_16;

booth_top u_booth_top(
    .xin              ( mul_a            ),
    .yin              ( mul_b            ),
    .booth_out_exp_1  ( booth_out_exp_1  ),
    .booth_out_exp_2  ( booth_out_exp_2  ),
    .booth_out_exp_3  ( booth_out_exp_3  ),
    .booth_out_exp_4  ( booth_out_exp_4  ),
    .booth_out_exp_5  ( booth_out_exp_5  ),
    .booth_out_exp_6  ( booth_out_exp_6  ),
    .booth_out_exp_7  ( booth_out_exp_7  ),
    .booth_out_exp_8  ( booth_out_exp_8  ),
    .booth_out_exp_9  ( booth_out_exp_9  ),
    .booth_out_exp_10 ( booth_out_exp_10 ),
    .booth_out_exp_11 ( booth_out_exp_11 ),
    .booth_out_exp_12 ( booth_out_exp_12 ),
    .booth_out_exp_13 ( booth_out_exp_13 ),
    .booth_out_exp_14 ( booth_out_exp_14 ),
    .booth_out_exp_15 ( booth_out_exp_15 ),
    .booth_out_exp_16  ( booth_out_exp_16  )
);

wallace_64_64 u_wallace_64_64(
    .booth_in0    ( booth_out_exp_1     ),
    .booth_in1    ( booth_out_exp_2     ),
    .booth_in2    ( booth_out_exp_3     ),
    .booth_in3    ( booth_out_exp_4     ),
    .booth_in4    ( booth_out_exp_5     ),
    .booth_in5    ( booth_out_exp_6     ),
    .booth_in6    ( booth_out_exp_7     ),
    .booth_in7    ( booth_out_exp_8     ),
    .booth_in8    ( booth_out_exp_9     ),
    .booth_in9    ( booth_out_exp_10    ),
    .booth_in10   ( booth_out_exp_11    ),
    .booth_in11   ( booth_out_exp_12    ),
    .booth_in12   ( booth_out_exp_13    ),
    .booth_in13   ( booth_out_exp_14    ),
    .booth_in14   ( booth_out_exp_15    ),
    .booth_in15   (  booth_out_exp_16   ),
    .wallace_sout (  ),
    .wallace_cout (  ),
    .add_out      ( mul_pro      )
);



endmodule