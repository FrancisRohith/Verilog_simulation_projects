module data_mem(
    input clk, write_en,
    input [31:0] addr, write_data,
    output [31:0] rd    
    );
    
    reg [31:0] RAM [127:0];
    integer i;
    initial begin
    for (i = 0; i < 129; i = i + 1)
        RAM[i] = 32'b0;
    end  
    
    assign rd = RAM[addr[31:2]];
    
    always @(posedge clk)
        if(write_en)
            RAM[addr[31:2]] <= write_data;
endmodule
