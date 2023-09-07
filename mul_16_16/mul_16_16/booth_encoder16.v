module booth_encoder16 (
    input   [15:0]   xin,
    input   [2 :0]   yin,

    output  [15:0]   booth_out
);

//b-4 booth encoder dat
wire [15:0] booth_data;
wire add_self,add_dself,minus_self,minus_dself;//four cases
wire m_cout;

assign add_self     = (yin == 3'b001) || (yin == 3'b010);//accumulate self
assign add_dself    = (yin == 3'b011);
assign minus_self   = (yin == 3'b101) || (yin == 3'b110);//minus self
assign minus_dself  = (yin == 3'b100);

//test mod
assign booth_data =  {16{add_self}}     & xin               | 
                     {16{add_dself}}    & {xin[14:0], 1'b0} |
                     {16{minus_self}}   & ~xin              |
                     {16{minus_dself}}  & ~(xin<<1)         ;

assign m_cout =  minus_self | minus_dself;//~ add “1”

assign booth_out = booth_data + m_cout;

endmodule