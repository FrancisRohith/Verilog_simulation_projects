module ROM32K(
    input clk,
    input [14:0] address,
    output reg [15:0] dout
);
    reg [15:0] rom [0:32767];

  always @(*posedge clk) begin
        dout = rom[address];
    end
endmodule
