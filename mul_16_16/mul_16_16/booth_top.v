module booth_top (
    input   [15:0]  xin,
    input   [15:0]  yin,

    output  [31:0]  booth_out_exp_1,
    output  [31:0]  booth_out_exp_2,
    output  [31:0]  booth_out_exp_3,
    output  [31:0]  booth_out_exp_4,
    output  [31:0]  booth_out_exp_5,
    output  [31:0]  booth_out_exp_6,
    output  [31:0]  booth_out_exp_7,
    output  [31:0]  booth_out_exp_8
);

wire [16:0] yin_exp = {yin,1'b0};
wire [15:0] booth_out [7:0];

genvar i;
generate
    for (i=0;i<=7;i=i+1) begin : booth_loop
        booth_encoder16 u_booth_encoder(
            .xin ( xin ),
            .yin ( yin_exp[2*(i+1):2*i] ),
            .booth_out  ( booth_out[i]  )
        );
    end
endgenerate

//expand 
assign  booth_out_exp_1   = {{16{booth_out[0][15]}} ,booth_out[0]       };
assign  booth_out_exp_2   = {{14{booth_out[1][15]}} ,booth_out[1],2'b0  };
assign  booth_out_exp_3   = {{12{booth_out[2][15]}} ,booth_out[2],4'b0  };
assign  booth_out_exp_4   = {{10{booth_out[3][15]}} ,booth_out[3],6'b0  };
assign  booth_out_exp_5   = {{ 8{booth_out[4][15]}} ,booth_out[4],8'b0  };
assign  booth_out_exp_6   = {{ 6{booth_out[5][15]}} ,booth_out[5],10'b0 };
assign  booth_out_exp_7   = {{ 4{booth_out[6][15]}} ,booth_out[6],12'b0 };
assign  booth_out_exp_8   = {{ 2{booth_out[7][15]}} ,booth_out[7],14'b0 };

endmodule