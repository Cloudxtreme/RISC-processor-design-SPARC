module  test_alu_32bit;
    wire [31:0] result;
    wire [0:0] N, Z, C, V;
    reg [31: 0] A_in, B_in;
    reg [5:0] opcode;
    reg [0:0] carry;
    
    parameter sim_time = 10000;                   //simulation time
    ALU_32bit alu (result, N, Z, C, V, A_in, B_in, opcode, carry); //syntax for instanciation
    initial #sim_time $finish;                  //simulation time
    initial begin
       //AND TEST    
       $display("Testing AND w. o. S");
        A_in = 32'h00000000; 
        B_in = 32'h11111111;
        
        opcode = 6'b000001;
        carry = 1'b0;
           
        #100
       $display("Testing AND with S");        
        A_in = 32'h11110000; 
        B_in = 32'h11111111;
        
        opcode = 6'b010001;
        carry = 1'b0; 
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
        #100
        
        //NAND TEST 
      $display("Testing NAND w. o. S");
        A_in = 32'h00000000; 
        B_in = 32'h11111111;
        
        opcode = 6'b000101;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
      
      $display("Testing NAND with S");  
        opcode = 6'b010101;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
        
      $display("Testing XOR with S");  
        opcode = 6'b010111;  // A XNOR B (bitwise) with S
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
        
      $display("Testing XOR with S");  
        opcode = 6'b010111;  // A XNOR B (bitwise) with S
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
        
      $display("Testing SHIFT LEFT LOGICAL w. o. S");  
        opcode = 6'b100101;  // A SHIFT LEFT B times w. o. S
        A_in = 32'h00000001;
        B_in = 32'b00000001;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
        
      $display("Testing SHIFT RIGHT LOGICAL");  
        opcode = 6'b100110;  // A SRL B w. o. S
        A_in = 32'h00000001;
        B_in = 32'b00000001;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
      
      $display("Testing SHIFT RIGHT ARITHMETICALLY");  
        opcode = 6'b100111; // A SLA
        A_in = 32'h00000002;
        B_in = 32'b00000001;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
      
       $display("Testing ADD w. o. S");  
        opcode = 6'b000000; // A ADD by  B 
        A_in = 32'h00000001;
        B_in = 32'b00000001;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
      
       $display("Testing ADD with S");  
        opcode = 6'b010000; // A ADD by  B 
        A_in = 32'h00000001;
        B_in = 32'b00000001;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
      
            $display("\tTest #2 ADD with S");  
            opcode = 6'b010000; // A ADD by  B 
            A_in = 32'hffffffff;
            B_in = 32'h00000001;
            #100
            $display("\t\tShowing register flags");
            $display("\t\t N Z C V ");
            $display("\t\t %b %b %b %b", N, Z, C, V);
      
         //oefmeaofmeaofmaf
         
       $display("Testing SUB without carry w. o. S");  
        opcode = 6'b000100; // A SUB by B without carry  
        A_in = 32'h00000002;
        B_in = 32'h00000001;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
      
       $display("Testing SUB without carry with S");  
        opcode = 6'b010100; // A SUB by B  
        A_in = 32'h01000001;
        B_in = 32'hf0000001;
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b", N, Z, C, V);
      
            $display("\tTest #2 SUB with carry with S");  
            opcode = 6'b011100; // A ADD by  B 
            A_in = 32'hefffffff;
            B_in = 32'hffffffff;
            #100
            $display("\t\tShowing register flags");
            $display("\t\t N Z C V ");
            $display("\t\t %b %b %b %b", N, Z, C, V);
      
    end
    
    initial begin
        $display ("\t Ain       Bin            opcode       result");
        $monitor ("\t%h   %h    %b    %h",A_in,B_in,opcode,result);
    end
endmodule
