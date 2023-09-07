module tb_wallace ();

    reg   [31:0]   booth_in0;
    reg   [31:0]   booth_in1;
    reg   [31:0]   booth_in2;
    reg   [31:0]   booth_in3;
    reg   [31:0]   booth_in4;
    reg   [31:0]   booth_in5;
    reg   [31:0]   booth_in6;
    reg   [31:0]   booth_in7;

    wire  [31:0]   wallace_sout;
    wire  [31:0]   wallace_cout;
    wire  [31:0]   add_out;

wallace_16_16 u_wallace_16_16(
    .booth_in0    ( booth_in0    ),
    .booth_in1    ( booth_in1    ),
    .booth_in2    ( booth_in2    ),
    .booth_in3    ( booth_in3    ),
    .booth_in4    ( booth_in4    ),
    .booth_in5    ( booth_in5    ),
    .booth_in6    ( booth_in6    ),
    .booth_in7    ( booth_in7    ),
    .wallace_sout ( wallace_sout ),
    .wallace_cout ( wallace_cout ),
    .add_out      ( add_out      )
);

initial begin
    booth_in0 = 'd10;
    booth_in1 = 'd10;
    booth_in2 = 'd10;
    booth_in3 = 'd10;
    booth_in4 = 'd10;
    booth_in5 = 'd10;
    booth_in6 = 'd10;
    booth_in7 = 'd10;

    #100
    $stop;
end
    
endmodule