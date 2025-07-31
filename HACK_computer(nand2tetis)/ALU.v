module ALU(
    input  [15:0] x, y,
    input zx, nx, zy, ny, f, no,
    output [15:0] out,
    output reg zr, ng
    );
    
    reg [15:0] temp_x, temp_y, temp_out;
    
    always @* begin
        temp_x = zx ? 0 : x;       
        temp_x = nx ? ~temp_x: temp_x;
        temp_y = zy ? 0 : y;
        temp_y = ny ? ~temp_y: temp_y;
        temp_out = f ? temp_x+temp_y: temp_x&temp_y;
        temp_out = no ? ~(temp_out) : temp_out;
        zr = (temp_out == 16'b0) ? 1 : 0;
        ng = temp_out[15];
     end 
        
     assign  out = temp_out;
    
endmodule
