module wallace_16_16 (
    input   [31:0]   booth_in0,
    input   [31:0]   booth_in1,
    input   [31:0]   booth_in2,
    input   [31:0]   booth_in3,
    input   [31:0]   booth_in4,
    input   [31:0]   booth_in5,
    input   [31:0]   booth_in6,
    input   [31:0]   booth_in7,

    output  [31:0]   wallace_sout,
    output  [31:0]   wallace_cout,
    output  [31:0]   add_out
);

//layer 1,weight 1
wire [31:0] S_1 [1:0];
wire [31:0] C_1 [1:0];

//layer 2,weight 2
wire [31:0] S_2 [1:0];
wire [31:0] C_2 [1:0];

//layer 3,weight 3
wire [31:0] S_3;
wire [31:0] C_3;

//shift
wire [31:0] C_1_shift [1:0];
wire [31:0] C_2_shift [1:0];
wire [31:0] C_3_shift ;

genvar i;
generate
    for (i=0;i<=1;i=i+1) begin : carry_shift_1
        assign C_1_shift[i] = C_1[i] << 1;
    end for (i=0;i<=1;i=i+1) begin : carry_shift_2
        assign C_2_shift[i] = C_2[i] << 1;
    end 
        assign C_3_shift = C_3 << 1; 
endgenerate

genvar j;
generate 
    //wallace layer 1
    for (j=0;j<=31;j=j+1) begin:loop_layer1
        full_adder u_full_adder_0(.cin  ( {booth_in0[j],booth_in1[j],booth_in2[j]}  ),.Cout ( C_1[0][j] ),.S    ( S_1[0][j] ));
        full_adder u_full_adder_1(.cin  ( {booth_in3[j],booth_in4[j],booth_in5[j]}  ),.Cout ( C_1[1][j] ),.S    ( S_1[1][j] ));
    end 
    //wallace layer 2
    for (j=0;j<=31;j=j+1) begin:loop_layer2
        full_adder u_full_adder_1_0(.cin  ( {S_1[0][j],C_1_shift[0][j],S_1[1][j]}      ),.Cout ( C_2[0][j] ),.S    ( S_2[0][j] ));
        full_adder u_full_adder_1_1(.cin  ( {C_1_shift[1][j],booth_in6[j],booth_in7[j]}),.Cout ( C_2[1][j] ),.S    ( S_2[1][j] ));
    end 
    //wallace layer 3
    for (j=0;j<=31;j=j+1) begin:loop_layer3
        full_adder u_full_adder_2_0(.cin  ( {S_2[0][j],C_2_shift[0][j],S_2[1][j]}  ),.Cout ( C_3[j] ),.S    ( S_3[j] ));
    end 
    //wallace layer 4
    for (j=0;j<=31;j=j+1) begin:loop_layer4
        full_adder u_full_adder_2_0(.cin  ( {S_3[j],C_3_shift[j],C_2_shift[1][j]}  ),.Cout ( wallace_cout[j] ),.S    ( wallace_sout[j] ));
    end 
endgenerate

// assign add_out = wallace_sout + (wallace_cout << 1); 

adder32 u_adder32(
    .a  ( wallace_sout ),
    .b  ( wallace_cout << 1 ),
    .S  ( add_out ),
    .C  (   )
);



endmodule