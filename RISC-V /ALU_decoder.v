module ALU_decoder(
    input opb5,
    input [2:0] func3,
    input func7b5,
    input [1:0] ALU_op,
    output reg [3:0] ALU_control
    );
    wire R_type_sub = func7b5 & opb5;
    always @*
        case(ALU_op)
            2'b00: ALU_control = 4'b1000; // LD/ST
            2'b01: ALU_control = 4'b1001; // BRANCH
            default: case(func3)
                        3'b000: if(R_type_sub)
                                    ALU_control = 4'b0001; 
                                else    
                                    ALU_control = 4'b0000;
                        3'b100: ALU_control = 4'b0100;
                        3'b110: ALU_control = 4'b0011;
                        3'b111: ALU_control = 4'b0010;
                        3'b001: ALU_control = 4'b0101;
                        3'b101: ALU_control = 4'b0110;
                        3'b010: ALU_control = 4'b1100;
                        3'b011: ALU_control = 4'b1101;                      
                        default: ALU_control = 4'bxxx;
                     endcase
        endcase
endmodule
