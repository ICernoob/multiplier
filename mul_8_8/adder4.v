//Carry look a head adder

module adder4 (
    input      [3:0]   a,
    input      [3:0]   b,
    input              cin,
    output     [3:0]   s,
    output             cout
);

wire [3:0] P;
wire [3:0] G;
wire C0,C1,C2,C3;

//P,G
assign P = a ^ b;
assign G = a & b;
//sum
assign s[0] = P[0] ^ cin;
assign s[1] = P[1] ^ C0;
assign s[2] = P[2] ^ C1;
assign s[3] = P[3] ^ C2;
//carry bit 
assign C0 = G[0] | (P[0] & cin);
assign C1 = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cin);
assign C2 = G[2] | (P[2] & G[1]) | (P[1] & P[2] & G[0]) | (P[0] & P[1] & P[2] & cin);
assign C3 = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[1] & P[2] & G[0]) | (P[0] & P[1] & P[2] & P[3] & cin);
assign cout = C3;
endmodule