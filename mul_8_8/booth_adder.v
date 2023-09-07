module booth_adder (
    input   [7:0]   mul_a,
    input   [7:0]   mul_b,
    output  [15:0]  mul_pro
);

//expand data
wire [8:0] yin_exp = {mul_b,1'b0};
wire [7:0] booth_out [3:0];

genvar i;
generate
    for (i=0;i<=3;i=i+1) begin:booth_cp
        booth_encoder u_booth_encoder(
            .xin        ( mul_a ),
            .yin        ( yin_exp[2*(i+1):2*i] ),
            .booth_out  ( booth_out[i]  )
        );
    end
endgenerate

wire [15:0] booth_out_exp [3:0];

// assign booth_out_exp[0] = {{7{booth_out[0][7]}},booth_out[0]};
// assign booth_out_exp[1] = {{5{booth_out[1][7]}},booth_out[1],2'b0};
// assign booth_out_exp[2] = {{3{booth_out[2][7]}},booth_out[2],4'b0};
// assign booth_out_exp[3] = {{1{booth_out[3][7]}},booth_out[3],6'b0};

assign booth_out_exp[0] = {{8{booth_out[0][7]}},booth_out[0]};
assign booth_out_exp[1] = {{6{booth_out[1][7]}},booth_out[1],2'b0};
assign booth_out_exp[2] = {{4{booth_out[2][7]}},booth_out[2],4'b0};
assign booth_out_exp[3] = {{2{booth_out[3][7]}},booth_out[3],6'b0};

// assign mul_pro = booth_out_exp[0] + booth_out_exp[1] + booth_out_exp[2] + booth_out_exp[3];

wire [15:0] S,S_1;
wire [15:0] C,C_1;
wire [15:0] C_shift;

assign C_shift = C << 1;
 
genvar j;
generate
    for (j=0;j<=15;j=j+1) begin:loop
        full_adder u_full_adder(
            .cin  ( {booth_out_exp[2][j],booth_out_exp[1][j],booth_out_exp[0][j]}  ),
            .Cout ( C[j] ),
            .S    ( S[j]     )
        );

        full_adder u_full_adder_1(
            .cin  ( {booth_out_exp[3][j],C_shift[j],S[j]}  ),
            .Cout ( C_1[j] ),
            .S    ( S_1[j]     )
        );
    end 
endgenerate

assign mul_pro = S_1 + (C_1 << 1);

endmodule