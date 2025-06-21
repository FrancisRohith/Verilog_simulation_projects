module controller(
    input [6:0] op,
    input [2:0] func3,
    input func7b5,
    input zero,
    output [1:0] result_src,
    output mem_write,
    output PC_src, ALU_src,
    output reg_write, jump,
    output [1:0] imm_src,
  output [3:0] ALU_controlS
    );
    
    wire [1:0] ALU_op;
    wire branch;
    
    main_decoder md(
        .op(op), 
        .result_src(result_src), 
        .mem_write(mem_write), 
        .branch(branch),
        .ALU_src(ALU_src),
        .reg_write(reg_write), 
        .jump(jump),
        .imm_src(imm_src),
        .ALU_op(ALU_op)
        );
    
    ALU_decoder ad(
        .opb5(op[5]),
        .func3(func3),
        .func7b5(func7b5),
        .ALU_op(ALU_op),
        .ALU_control(ALU_control)
        );
    
    assign PC_src = branch & zero | jump;
    
endmodule
