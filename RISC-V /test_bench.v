module testbench(    );

reg clk, reset;
wire [31:0] write_data, data_addr, PC, instr, read_data;
wire mem_write;

processor dut(
    .clk(clk),
    .reset(reset),
    .write_data(write_data), 
    .data_addr(data_addr),
    .mem_write(mem_write),
    .PC(PC), 
    .instr(instr), 
    .read_data(read_data));

always  begin
    #5 clk = ~clk;
end

always @(negedge clk)
  begin
    if(mem_write) begin
      if(data_addr === 100 & write_data === 25) begin
        $display("Simulation succeeded");
        $stop;
      end else if (data_addr !== 96) begin
        $display("Simulation failed");
        $stop;
      end
    end
  end

endmodule
