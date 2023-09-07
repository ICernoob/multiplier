module booth_encoder32 (
    input   [31:0]   xin,
    input   [2 :0]   yin,

    output  [31:0]   booth_out
);

//b-4 booth encoder dat
wire [31:0] booth_data;
wire add_self,add_dself,minus_self,minus_dself;
wire m_cout;

assign add_self  = (yin == 3'b001) || (yin == 3'b010);//accumulate self
assign add_dself = (yin == 3'b011);
assign minus_self= (yin == 3'b101) || (yin == 3'b110);//minus self
assign minus_dself = (yin == 3'b100);

// assign booth_data =  {9{add_self}}  & {xin[7], xin} | 
//                     {9{add_dself}} & {xin,1'b0 } |
//                     {9{minus_self}} & {~xin[7],~xin} |
//                     {9{minus_dself}} & {~xin, 1'b1} ;

//test mod
assign booth_data =  {32{add_self}}  & xin | 
                    {32{add_dself}} & {xin[62:0], 1'b0} |
                    {32{minus_self}} & ~xin |
                    {32{minus_dself}} & ~(xin<<1) ;

assign m_cout =  minus_self | minus_dself;  

assign booth_out = booth_data + m_cout;
endmodule