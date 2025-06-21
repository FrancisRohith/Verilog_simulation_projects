module ALU(
    input [31:0] A, B,
    input [3:0] control,
    output reg [31:0] ALU_result,
    output reg zero
    );
    
    localparam ADD = 4'b0000;
    localparam SUB = 4'b0001;
    localparam AND = 4'b0010;
    localparam OR  = 4'b0011;
    localparam XOR = 4'b0100;
    localparam SLL = 4'b0101;
    localparam SRL = 4'b0110;
    localparam SRA = 4'b0111;
    localparam SLT = 4'b1100;
    localparam SLTU = 4'b1101;
    localparam BRANCH = 4'b1001;
    localparam LD_ST = 4'b1000;
    
    wire [32:0] ALU_minus = A - B;
    wire [32:0] ALU_plus = A + B;
    
    always @* begin
        case(control)
            ADD: ALU_result = ALU_plus[31:0];
            SUB: ALU_result = ALU_minus[31:0];
            AND: ALU_result = A & B;
            OR:  ALU_result = A | B;
            XOR: ALU_result = A ^ B;
            SLL: ALU_result = A << B[5:0];
            SRL: ALU_result = A >> B[5:0];
            SRA: ALU_result = A >>> B[5:0];
            SLT: ALU_result = (A[31] ^ B[31] ? A[31] : ALU_minus[32]);
            SLTU: ALU_result = ALU_minus[32];
            BRANCH: ALU_result <= ALU_minus;
            LD_ST: ALU_result <= ALU_plus[31:0];             
            default: begin  
                        ALU_result = 64'b0;
                        zero = 1'b1;
                     end            
        endcase
        
        zero = (ALU_result == 64'b0);
      
        end
                
endmodule
