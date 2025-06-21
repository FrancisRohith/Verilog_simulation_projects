module main_decoder(
    input [6:0] op,
    output [1:0] result_src,
    output mem_write,
    output branch, ALU_src,
    output reg_write, jump,
    output [1:0] imm_src,
    output [1:0] ALU_op
    );
    
    reg [10:0] controls;
    assign {reg_write, imm_src, ALU_src, mem_write,
                     result_src, branch, ALU_op, jump} = controls;
                     
    always @*
        case(op)
            7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // LOAD
            7'b0100011: controls = 11'b0_01_1_1_00_0_00_0; // STORE
            7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0; // REG
            7'b1100011: controls = 11'b0_10_0_0_00_1_01_0; // BRANCH
            7'b0010011: controls = 11'b1_00_1_0_00_0_10_0; // IMM
            7'b1101111: controls = 11'b1_11_0_0_10_0_00_1; // JUMP
            default   : controls = 11'bx_xx_x_x_xx_x_xx_x;
        endcase
endmodule
