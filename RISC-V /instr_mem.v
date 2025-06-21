module instr_mem(
    input [31:0] addr,
    output [31:0] instr
    );
    
    reg [31:0] RAM [63:0];
    integer i;
    initial begin
        $display("Loading memory from file..."); 
        $readmemh("riscv-test.txt", RAM);
        $display("Instructions loaded:");
        for (i = 0; i < 21; i = i + 1)
            $display("RAM[%0d] = %h", i, RAM[i]);

    end
    assign instr = RAM[addr[31:2]];
endmodule
