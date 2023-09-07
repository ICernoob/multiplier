module tb_mul ();

    reg   [15:0]  mul_a;
    reg   [15:0]  mul_b;
    wire  [31:0]  mul_pro;

mul_16_16 u_mul_16_16(
    .mul_a ( mul_a ),
    .mul_b ( mul_b ),
    .mul_pro  ( mul_pro  )
);


initial begin
    mul_a = 15'd22;
    mul_b = 15'd112;

    #100
    $stop;
end
    
endmodule