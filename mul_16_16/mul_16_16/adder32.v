module adder32 (
    input   [31:0]  a,
    input   [31:0]  b,

    output  [31:0]  S,
    output          C
);

wire [3:0] s_4 [7:0];
wire [15:0] cout;

genvar i;
generate
    for (i=0;i<=7;i=i+1)begin:loop
        if (i==0) begin
            adder4 u_adder4_0(
                .a      ( a[4*(i+1)-1:4*i]),
                .b      ( b[4*(i+1)-1:4*i]),
                .cin    ( 1'b0  ),
                .s      ( s_4[i]  ),
                .cout   ( cout[i])
            );
        end else begin
            adder4 u_adder4(
                .a      ( a[4*(i+1)-1:4*i]),
                .b      ( b[4*(i+1)-1:4*i]),
                .cin    ( cout[i-1]  ),
                .s      ( s_4[i]  ),
                .cout   ( cout[i])
            );
        end 
    end
endgenerate

assign S = {s_4[7],s_4[6],s_4[5],s_4[4],
            s_4[3],s_4[2],s_4[1],s_4[0]};

assign C = cout[15];

endmodule