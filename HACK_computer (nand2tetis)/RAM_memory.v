module Memory(
    input clk,
    input [15:0] in,
    input [14:0] address,
    input ld,
    output [15:0] out
     );
    
    wire [15:0] outs [0:2];
    wire ld_sel [0:2];
    
    assign ld_sel[0] = ld && ((address[14:13] == 2'b00) || (address[14:13] == 2'b01)); // 0 - 16K
    assign ld_sel[1] = ld && (address[14:13] == 2'b10); // 16K - 24K
    assign ld_sel[2] = ld && (address == 15'b111111111111111); 
    
    RAM16K data_mem(.clk(clk), .in(in), .address(address[13:0]), .ld(ld_sel[0]), .out(outs[0]));
    SCREEN SCR(.clk(clk), .in(in), .address(address[12:0]), .ld(ld_sel[1]), .out(outs[1]));
    Register KYBD(.clk(clk), .in(in), .ld(ld_sel[2]), .out(outs[2]));
    
    assign out = ld_sel[0] ? outs[0] : 
                 ld_sel[1] ? outs[1] : 
                 ld_sel [2] ? outs[2] : 
                 15'bz;
    
endmodule

module SCREEN(
    input clk,
    input [15:0] in,
    input [12:0] address,
    input ld,
    output [15:0] out
    );
    
    wire [15:0] outs [0:2];
    wire ld_sel [0:2];
    assign ld_sel[0] = ld & (address[12] == 1'b0);
    assign ld_sel[1] = ld & (address[12] == 1'b1);
    RAM4K R4K0(.clk(clk), .in(in), .address(address[11:0]), .ld(ld_sel[0]), .out(outs[0]));
    RAM4K R4K1(.clk(clk), .in(in), .address(address[11:0]), .ld(ld_sel[1]), .out(outs[1]));
    assign out = outs[address[12]];
endmodule

module RAM16K(
    input clk,
    input [15:0] in,
    input [13:0] address,
    input ld,
    output [15:0] out
    );
    
    wire [15:0] outs [0:3];
    wire ld_sel [0:3];
    
    assign ld_sel[0] = ld && (address[13:12] == 2'b00);
    assign ld_sel[1] = ld && (address[13:12] == 2'b01);
    assign ld_sel[2] = ld && (address[13:12] == 2'b10);
    assign ld_sel[3] = ld && (address[13:12] == 2'b11);
    
    RAM4K R4K0(.clk(clk), .in(in), .address(address[11:0]), .ld(ld_sel[0]), .out(outs[0]));
    RAM4K R4K1(.clk(clk), .in(in), .address(address[11:0]), .ld(ld_sel[1]), .out(outs[1]));
    RAM4K R4K2(.clk(clk), .in(in), .address(address[11:0]), .ld(ld_sel[2]), .out(outs[2]));
    RAM4K R4K3(.clk(clk), .in(in), .address(address[11:0]), .ld(ld_sel[3]), .out(outs[3]));
    
    assign out = outs[address[13:12]];
    
endmodule

module RAM4K(
    input clk,
    input [15:0] in,
    input [11:0] address,
    input ld,
    output [15:0] out);
    
    wire [15:0] outs [0:7];
    wire ld_sel [0:7];
    
    assign ld_sel[0] = ld && (address[11:9] == 3'b000);
    assign ld_sel[1] = ld && (address[11:9] == 3'b001);
    assign ld_sel[2] = ld && (address[11:9] == 3'b010);
    assign ld_sel[3] = ld && (address[11:9] == 3'b011);
    assign ld_sel[4] = ld && (address[11:9] == 3'b100);
    assign ld_sel[5] = ld && (address[11:9] == 3'b101);
    assign ld_sel[6] = ld && (address[11:9] == 3'b110);
    assign ld_sel[7] = ld && (address[11:9] == 3'b111);
    
    RAM512 R5120(.clk(clk), .in(in), .address(address[8:0]), .ld(ld_sel[0]), .out(outs[0]));
    RAM512 R5121(.clk(clk), .in(in), .address(address[8:0]), .ld(ld_sel[1]), .out(outs[1]));
    RAM512 R5122(.clk(clk), .in(in), .address(address[8:0]), .ld(ld_sel[2]), .out(outs[2]));
    RAM512 R5123(.clk(clk), .in(in), .address(address[8:0]), .ld(ld_sel[3]), .out(outs[3]));
    RAM512 R5124(.clk(clk), .in(in), .address(address[8:0]), .ld(ld_sel[4]), .out(outs[4]));
    RAM512 R5125(.clk(clk), .in(in), .address(address[8:0]), .ld(ld_sel[5]), .out(outs[5]));
    RAM512 R5126(.clk(clk), .in(in), .address(address[8:0]), .ld(ld_sel[6]), .out(outs[6]));
    RAM512 R5127(.clk(clk), .in(in), .address(address[8:0]), .ld(ld_sel[7]), .out(outs[7]));
    
    assign out = outs[address[11:9]];
endmodule

module RAM512(
    input clk,
    input [15:0] in,
    input [8:0] address,
    input ld,
    output [15:0] out);
    
    wire [15:0] outs [0:7];
    wire ld_sel [0:7];
    
    assign ld_sel[0] = ld && (address[8:6] == 3'b000);
    assign ld_sel[1] = ld && (address[8:6] == 3'b001);
    assign ld_sel[2] = ld && (address[8:6] == 3'b010);
    assign ld_sel[3] = ld && (address[8:6] == 3'b011);
    assign ld_sel[4] = ld && (address[8:6] == 3'b100);
    assign ld_sel[5] = ld && (address[8:6] == 3'b101);
    assign ld_sel[6] = ld && (address[8:6] == 3'b110);
    assign ld_sel[7] = ld && (address[8:6] == 3'b111);
    
    RAM64 R640(.clk(clk), .in(in), .address(address[5:0]), .ld(ld_sel[0]), .out(outs[0]));
    RAM64 R641(.clk(clk), .in(in), .address(address[5:0]), .ld(ld_sel[1]), .out(outs[1]));
    RAM64 R642(.clk(clk), .in(in), .address(address[5:0]), .ld(ld_sel[2]), .out(outs[2]));
    RAM64 R643(.clk(clk), .in(in), .address(address[5:0]), .ld(ld_sel[3]), .out(outs[3]));
    RAM64 R644(.clk(clk), .in(in), .address(address[5:0]), .ld(ld_sel[4]), .out(outs[4]));
    RAM64 R645(.clk(clk), .in(in), .address(address[5:0]), .ld(ld_sel[5]), .out(outs[5]));
    RAM64 R646(.clk(clk), .in(in), .address(address[5:0]), .ld(ld_sel[6]), .out(outs[6]));
    RAM64 R647(.clk(clk), .in(in), .address(address[5:0]), .ld(ld_sel[7]), .out(outs[7]));
    
    assign out = outs[address[8:6]];
endmodule

module RAM64(
    input clk,
    input [15:0] in,
    input [5:0] address,
    input ld,
    output [15:0] out);
    
    wire [15:0] outs [0:7];
    wire ld_sel [0:7];
    
//    assign ld_sel[0] = ld & (address[5:3] == 3'b000);
//    assign ld_sel[1] = ld & (address[5:3] == 3'b001);
//    assign ld_sel[2] = ld & (address[5:3] == 3'b010);
//    assign ld_sel[3] = ld & (address[5:3] == 3'b011);
//    assign ld_sel[4] = ld & (address[5:3] == 3'b100);
//    assign ld_sel[5] = ld & (address[5:3] == 3'b101);
//    assign ld_sel[6] = ld & (address[5:3] == 3'b110);
//    assign ld_sel[7] = ld & (address[5:3] == 3'b111);
    
    genvar i;
    generate
      for (i = 0; i < 8; i = i + 1) begin : RAM_BANKS
        assign ld_sel[i] = ld && (address[5:3] == i);
      end
    endgenerate
    
    RAM8 R80(.clk(clk), .in(in), .address(address[2:0]), .ld(ld_sel[0]), .out(outs[0]));
    RAM8 R81(.clk(clk), .in(in), .address(address[2:0]), .ld(ld_sel[1]), .out(outs[1]));
    RAM8 R82(.clk(clk), .in(in), .address(address[2:0]), .ld(ld_sel[2]), .out(outs[2]));
    RAM8 R83(.clk(clk), .in(in), .address(address[2:0]), .ld(ld_sel[3]), .out(outs[3]));
    RAM8 R84(.clk(clk), .in(in), .address(address[2:0]), .ld(ld_sel[4]), .out(outs[4]));
    RAM8 R85(.clk(clk), .in(in), .address(address[2:0]), .ld(ld_sel[5]), .out(outs[5]));
    RAM8 R86(.clk(clk), .in(in), .address(address[2:0]), .ld(ld_sel[6]), .out(outs[6]));
    RAM8 R87(.clk(clk), .in(in), .address(address[2:0]), .ld(ld_sel[7]), .out(outs[7]));
    
    assign out = outs[address[5:3]];
endmodule

module RAM8(
    input clk,
    input [15:0] in,
    input [2:0] address,
    input ld,    
    output [15:0] out);
    
    wire [15:0] outs [0:7];
    wire ld_sel [0:7];
    
    assign ld_sel[0] = ld && (address == 3'b000);
    assign ld_sel[1] = ld && (address == 3'b001);
    assign ld_sel[2] = ld && (address == 3'b010);
    assign ld_sel[3] = ld && (address == 3'b011);
    assign ld_sel[4] = ld && (address == 3'b100);
    assign ld_sel[5] = ld && (address == 3'b101);
    assign ld_sel[6] = ld && (address == 3'b110);
    assign ld_sel[7] = ld && (address == 3'b111);
    
    Register R0(.clk(clk), .in(in), .ld(ld_sel[0]), .out(outs[0]));
    Register R1(.clk(clk), .in(in), .ld(ld_sel[1]), .out(outs[1]));
    Register R2(.clk(clk), .in(in), .ld(ld_sel[2]), .out(outs[2]));
    Register R3(.clk(clk), .in(in), .ld(ld_sel[3]), .out(outs[3]));
    Register R4(.clk(clk), .in(in), .ld(ld_sel[4]), .out(outs[4]));
    Register R5(.clk(clk), .in(in), .ld(ld_sel[5]), .out(outs[5]));
    Register R6(.clk(clk), .in(in), .ld(ld_sel[6]), .out(outs[6]));
    Register R7(.clk(clk), .in(in), .ld(ld_sel[7]), .out(outs[7]));
    
    assign out = outs[address];
    
endmodule

module Register(
    input clk, 
    input [15:0] in, 
    input ld,
    output reg [15:0] out
    );       
    always @(posedge clk) begin
        if(ld) out <= in;
    end   
endmodule
