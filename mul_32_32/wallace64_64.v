module wallace_64_64 (
    input   [63:0]   booth_in0,
    input   [63:0]   booth_in1,
    input   [63:0]   booth_in2,
    input   [63:0]   booth_in3,
    input   [63:0]   booth_in4,
    input   [63:0]   booth_in5,
    input   [63:0]   booth_in6,
    input   [63:0]   booth_in7,
    input   [63:0]   booth_in8,
    input   [63:0]   booth_in9,
    input   [63:0]   booth_in10,
    input   [63:0]   booth_in11,
    input   [63:0]   booth_in12,
    input   [63:0]   booth_in13,
    input   [63:0]   booth_in14,
    input   [63:0]   booth_in15,

    output  [63:0]   wallace_sout,
    output  [63:0]   wallace_cout,
    output  [63:0]   add_out
);

//layer 1,weight 1
wire [63:0] S_1 [4:0];
wire [63:0] C_1 [4:0];

//layer 2,weight 2
wire [63:0] S_2 [2:0];
wire [63:0] C_2 [2:0];

//layer 3,weight 3
wire [63:0] S_3 [1:0];
wire [63:0] C_3 [1:0];

//layer 4,weight 4
wire [63:0] S_4 [1:0];
wire [63:0] C_4 [1:0];

//layer 5,weigth 5
wire [63:0] S_5;
wire [63:0] C_5;

//shift
wire [63:0] C_1_shift [4:0];
wire [63:0] C_2_shift [2:0];
wire [63:0] C_3_shift [1:0];
wire [63:0] C_4_shift [1:0];
wire [63:0] C_5_shift ;

genvar i;
generate
    for (i=0;i<=4;i=i+1) begin : carry_shift_1
        assign C_1_shift[i] = C_1[i] << 1;
    end for (i=0;i<=2;i=i+1) begin : carry_shift_2
        assign C_2_shift[i] = C_2[i] << 1;
    end for (i=0;i<=1;i=i+1) begin : carry_shift_3
        assign C_3_shift[i] = C_3[i] << 1;
    end  for (i=0;i<=1;i=i+1) begin : carry_shift_4
        assign C_4_shift[i] = C_4[i] << 1;
    end
    assign C_5_shift = C_5 << 1;
endgenerate

genvar j;
generate 
    //wallace layer 1
    for (j=0;j<=63;j=j+1) begin:loop_layer1
        full_adder u_full_adder_0(.cin  ( {booth_in0[j],booth_in1[j],booth_in2[j]}  ),.Cout ( C_1[0][j] ),.S    ( S_1[0][j] ));
        full_adder u_full_adder_1(.cin  ( {booth_in3[j],booth_in4[j],booth_in5[j]}  ),.Cout ( C_1[1][j] ),.S    ( S_1[1][j] ));
        full_adder u_full_adder_2(.cin  ( {booth_in6[j],booth_in7[j],booth_in8[j]}  ),.Cout ( C_1[2][j] ),.S    ( S_1[2][j] ));
        full_adder u_full_adder_3(.cin  ( {booth_in9[j],booth_in10[j],booth_in11[j]}),.Cout ( C_1[3][j] ),.S    ( S_1[3][j] ));
        full_adder u_full_adder_4(.cin  ( {booth_in12[j],booth_in13[j],booth_in14[j]}),.Cout ( C_1[4][j] ),.S    ( S_1[4][j] ));
    end 
    //wallace layer 2
    for (j=0;j<=63;j=j+1) begin:loop_layer2
        full_adder u_full_adder_1_0(.cin  ( {S_1[0][j],C_1_shift[0][j],S_1[1][j]}  ),.Cout ( C_2[0][j] ),.S    ( S_2[0][j] ));
        full_adder u_full_adder_1_1(.cin  ( {C_1_shift[1][j],S_1[2][j],C_1_shift[2][j]}),.Cout ( C_2[1][j] ),.S    ( S_2[1][j] ));
        full_adder u_full_adder_1_2(.cin  ( {S_1[3][j],C_1_shift[3][j],S_1[4][j]}  ),.Cout ( C_2[2][j] ),.S    ( S_2[2][j] ));
    end 
    //wallace layer 3
    for (j=0;j<=63;j=j+1) begin:loop_layer3
        full_adder u_full_adder_2_0(.cin  ( {S_2[0][j],C_2_shift[0][j],S_2[1][j]}  ),.Cout ( C_3[0][j] ),.S    ( S_3[0][j] ));
        full_adder u_full_adder_2_1(.cin  ( {C_2_shift[1][j],S_2[2][j],C_2_shift[2][j]}  ),.Cout ( C_3[1][j] ),.S    ( S_3[1][j] ));
    end 
    //wallace layer 4
    for (j=0;j<=63;j=j+1) begin:loop_layer4
        full_adder u_full_adder_2_0(.cin  ( {S_3[0][j],C_3_shift[0][j],S_3[1][j]}  ),.Cout ( C_4[0][j] ),.S    ( S_4[0][j] ));
        full_adder u_full_adder_2_1(.cin  ( {C_3_shift[1][j],C_1_shift[4][j],booth_in15[j]}  ),.Cout ( C_4[1][j] ),.S    ( S_4[1][j] ));
    end 
    //wallace layer 4
    for (j=0;j<=63;j=j+1) begin:loop_layer5
        full_adder u_full_adder_2_0(.cin  ( {S_4[0][j],C_4_shift[0][j],S_4[1][j]}  ),.Cout ( C_5[j] ),.S    ( S_5[j] ));
    end 
    //wallace layer 6
    for (j=0;j<=63;j=j+1) begin:loop_layer6
        full_adder u_full_adder_2_0(.cin  ( {S_4[0][j],C_4_shift[0][j],S_4[1][j]}  ),.Cout ( C_5[j] ),.S    ( S_5[j] )
        );
    end 
    //wallace last layer
    for (j=0;j<=63;j=j+1) begin:loop_layer7
        full_adder u_full_adder_2_0(.cin  ( {S_5[j],C_5_shift[j],C_4_shift[1][j]}  ),.Cout ( wallace_cout[j] ),.S    ( wallace_sout[j] ));
    end
endgenerate

// assign add_out = wallace_sout + (wallace_cout << 1); 

//last layer adder
adder64 u_adder64(
    .a ( wallace_sout ),
    .b ( (wallace_cout << 1) ),
    .S ( add_out ),
    .C  (   )
);


endmodule