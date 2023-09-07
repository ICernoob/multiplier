module tb_mul ();

    reg   [31:0]  mul_a;
    reg   [31:0]  mul_b;
    wire  [63:0]  mul_pro;

mul_32_32 u_mul_32_32(
    .mul_a ( mul_a ),
    .mul_b ( mul_b ),
    .mul_pro  ( mul_pro  )
);

initial begin
    mul_a = 32'b11111111111111111111111111110111;
    mul_b = 32'd112;

    #100
    $stop;
end
    
endmodule