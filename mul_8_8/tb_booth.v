module tb_booth ();
    reg   [7:0]   mul_a;
    reg   [7:0]   mul_b;
    wire  [15:0]  mul_pro;

booth_adder u_booth_adder(
    .mul_a ( mul_a ),
    .mul_b ( mul_b ),
    .mul_pro  ( mul_pro  )
);

initial begin
    mul_a = 8'd55;
    mul_b = 8'd100;
    #100
    mul_a = 8'd55;
    mul_b = 8'b10000011;
    #1000
    $stop;
end



endmodule