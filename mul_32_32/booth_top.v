module booth_top (
    input   [31:0]  xin,
    input   [31:0]  yin,

    output  [63:0]  booth_out_exp_1,
    output  [63:0]  booth_out_exp_2,
    output  [63:0]  booth_out_exp_3,
    output  [63:0]  booth_out_exp_4,
    output  [63:0]  booth_out_exp_5,
    output  [63:0]  booth_out_exp_6,
    output  [63:0]  booth_out_exp_7,
    output  [63:0]  booth_out_exp_8,
    output  [63:0]  booth_out_exp_9,
    output  [63:0]  booth_out_exp_10,
    output  [63:0]  booth_out_exp_11,
    output  [63:0]  booth_out_exp_12,
    output  [63:0]  booth_out_exp_13,
    output  [63:0]  booth_out_exp_14,
    output  [63:0]  booth_out_exp_15,
    output  [63:0]  booth_out_exp_16
);

wire [32:0] yin_exp = {yin,1'b0};
wire [31:0] booth_out [15:0];

genvar i;
generate
    for (i=0;i<=15;i=i+1) begin : booth_loop
        booth_encoder32 u_booth_encoder(
            .xin ( xin ),
            .yin ( yin_exp[2*(i+1):2*i] ),
            .booth_out  ( booth_out[i]  )
        );
    end
endgenerate

//expand 
assign  booth_out_exp_1   = {{32{booth_out[0][31]}} ,booth_out[0]       };
assign  booth_out_exp_2   = {{30{booth_out[1][31]}} ,booth_out[1],2'b0  };
assign  booth_out_exp_3   = {{28{booth_out[2][31]}} ,booth_out[2],4'b0  };
assign  booth_out_exp_4   = {{26{booth_out[3][31]}} ,booth_out[3],6'b0  };
assign  booth_out_exp_5   = {{24{booth_out[4][31]}} ,booth_out[4],8'b0  };
assign  booth_out_exp_6   = {{22{booth_out[5][31]}} ,booth_out[5],10'b0 };
assign  booth_out_exp_7   = {{20{booth_out[6][31]}} ,booth_out[6],12'b0 };
assign  booth_out_exp_8   = {{18{booth_out[7][31]}} ,booth_out[7],14'b0 };
assign  booth_out_exp_9   = {{16{booth_out[8][31]}} ,booth_out[8],16'b0 };
assign  booth_out_exp_10  = {{14{booth_out[9][31]}} ,booth_out[9],18'b0 };
assign  booth_out_exp_11  = {{12{booth_out[10][31]}},booth_out[10],20'b0};
assign  booth_out_exp_12  = {{10{booth_out[11][31]}},booth_out[11],22'b0};
assign  booth_out_exp_13  = {{ 8{booth_out[12][31]}},booth_out[12],24'b0};
assign  booth_out_exp_14  = {{ 6{booth_out[13][31]}},booth_out[13],26'b0};
assign  booth_out_exp_15  = {{ 4{booth_out[14][31]}},booth_out[14],28'b0};
assign  booth_out_exp_16  = {{ 2{booth_out[15][31]}},booth_out[15],30'b0};

endmodule