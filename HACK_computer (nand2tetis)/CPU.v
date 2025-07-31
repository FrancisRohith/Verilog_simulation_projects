module CPU(
    input clk,
    input [15:0] instr,
    input [15:0] inM,
    input rst,
    output [15:0] outM,
    output [14:0] addressM,
    output [15:0] pc, 
    output writeM
    ); 
    
    wire ld_sel[2:0];
    wire zr, ng;
    wire [15:0] outs[0:2], Aout, Dout, ALUout;
    wire isC = instr[15];
    wire Aload = ~isC | (isC & instr[5]);
    wire Dload = isC & instr[4];
    
    wire jump = (instr[15:13] == 3'b111);  
    wire jmp = (instr[0] & zr) | (instr[1] & ng) | (instr[2] & ~(zr | ng)); 

    wire PCload = isC & jmp;
    wire PCinc = ~PCload;
    
    MUX16 mux0(.in1(ALUout), .in2(instr), .sel(~isC), .out(outs[0])); 
    Register A(.clk(clk), .in(outs[0]), .ld(Aload), .out(Aout));
    MUX16 mux1(.in1(Aout), .in2(inM), .sel(instr[12]), .out(outs[2])); 
    Register D(.clk(clk), .in(ALUout), .ld(Dload), .out(Dout));
    ALU alu(.x(Dout), .y(outs[2]),.zx(instr[11]), .nx(instr[10]), .zy(instr[9]), .ny(instr[8]),
                                         .f(instr[7]), .no(instr[6]), .zr(zr), .ng(ng), .out(ALUout));
    counter prgrm_cntr(.clk(clk), .in(Aout), .rst(rst), .ld(PCload), .inc(PCinc), .out(pc));
    
    assign addressM = Aout[14:0];
    assign outM = ALUout;
    assign writeM = isC & instr[3];
    
endmodule
