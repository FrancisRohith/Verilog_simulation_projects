module HACK(
    input clk, 
    input rst
    );
    wire [15:0] inM, instr, outM, pc;
    wire [14:0] addressM;
    wire writeM;
    Memory mem(.clk(clk), .in(outM), .address(addressM), .ld(writeM), .out(inM));
    CPU cpu(.clk(clk), .inM(inM), .instr(instr), .rst(rst), .writeM(writeM), .addressM(addressM), .outM(outM), .pc(pc));
    ROM32K R32K(.clk(clk), .address(pc[14:0]), .out(instr)); 
    
endmodule
