module processor_top(
    input clk, reset,
    output [31:0] write_data, data_addr, PC, instr, read_data,
    output mem_write
    );
    
    RISCV riscv( 
        .clk(clk), 
        .reset(reset),
        .read_data(read_data),
        .instr(instr),
        .PC(PC),
        .mem_write(mem_write),
        .ALU_result(data_addr), 
        .write_data(write_data)
    );
    
    instr_mem imem(
        .addr(PC), 
        .instr(instr));
        
    data_mem dmem(
        .clk(clk),
        .write_en(mem_write),
        .addr(data_addr),
        .write_data(write_data),
        .rd(read_data)
        );
endmodule
