module extend(
    input [31:7] instr,
    input [1:0] imm_src,
    output reg [31:0] imm_ext
    );
    
    always @*
        case(imm_src)
            2'b00: imm_ext = {{20{instr[31]}}, instr[31:20]}; // IMM
            2'b01: imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // STR
            2'b10: imm_ext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; // BR
            2'b11: imm_ext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; // JAL
            default: imm_ext = 32'bx;
        endcase
endmodule
