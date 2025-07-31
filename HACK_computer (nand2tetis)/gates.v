module Gates(

    );
endmodule

module MUX16(
    input [15:0] in1,
    input [15:0] in2,
    input sel,
    output [15:0] out);
    
    assign out = sel ? in2 : in1;
    
endmodule
