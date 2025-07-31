module counter(
    input clk,
    input [15:0] in,
    input ld, inc, rst,
    output reg [15:0] out
    );
    
    always @(posedge clk) begin
        if(rst) out <= 0;
        else if(ld) out <= in;
        else if(inc) out <= out + 1;
        else out <= out;
        end
    
    
endmodule
