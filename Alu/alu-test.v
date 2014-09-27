module  test_alu_32bit;
    wire [31:0] result;
    wire [0:0] N, Z, C, V;
    reg [31: 0] A_in, B_in;
    reg [5:0] opcode;
    reg [0:0] carry;
    
    parameter sim_time = 100;                   //simulation time
    ALU_32bit alu (result, N, Z, C, V, A_in, B_in, opcode, carry); //syntax for instanciation
    initial #sim_time $finish;                  //simulation time
    initial begin
        A_in = 32'h00000000; 
        B_in = 32'h11111111;
        
        opcode = 6'b000001;
        carry = 1'b0;   
        
        A_in = 32'h11110000; 
        B_in = 32'h11111111;
        
        opcode = 6'b000001;
        carry = 1'b0; 
    end
    
    initial begin
        $display (" Ain    Bin      opcode       result");
        $monitor (" %h   %h  %b  %h",A_in,B_in,opcode,result);
    end
endmodule
