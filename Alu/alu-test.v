module  test_alu_32bit;
    wire [31:0] result;
    wire [0:0] N, Z, C, V;
    reg [31: 0] A_in, B_in;
    reg [5:0] opcode;
    reg [0:0] carry, ALUE;
    
    parameter sim_time = 10000;                   //simulation time
    ALU_32bit alu (result, N, Z, V, C, A_in, B_in, opcode, carry, ALUE); //syntax for instanciation
    initial #sim_time $finish;                  //simulation time
    initial begin
       //AND TEST    
       
       $display("|---------- Testing logical functions -----------|");
       $display("\t============ AND ===========");  
       $display("\tTesting AND w. o. S");
        A_in = 32'h00000000; 
        B_in = 32'h11111111;
        
        opcode = 6'b000001;
        carry = 1'b0;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h\n",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
       $display("\tTesting AND with S");        
        A_in = 32'h11110000; 
        B_in = 32'h11111111;
        
        opcode = 6'b010001;
        carry = 1'b0;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h\n",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b\n", N, Z, C, V);
        #100
        
        //NAND TEST 
      $display("\tTesting NAND w. o. S");
        A_in = 32'h00000000; 
        B_in = 32'h11111111;
        
        opcode = 6'b000101;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b\n", N, Z, C, V);
        #100
        
      $display("\tTesting NAND with S");  
        opcode = 6'b010101;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b\n", N, Z, C, V);
        #100
        
      $display("\t============ XOR ===========");  
      $display("\tTesting XOR with S");  
        opcode = 6'b010111;  // A XNOR B (bitwise) with S
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b\n", N, Z, C, V);
        
      $display("\tTesting XOR with S");  
        opcode = 6'b010111;  // A XNOR B (bitwise) with S
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b\n", N, Z, C, V);
      
      $display("\t============ SLL ===========");  
      $display("\tTesting SHIFT LEFT LOGICAL");  
        opcode = 6'b100101;  // A SHIFT LEFT B times w. o. S
        A_in = 32'h00000001;
        B_in = 32'b00000001;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b\n", N, Z, C, V);
        
      $display("\t============ SRL ===========");  
      $display("\tTesting SHIFT RIGHT LOGICAL");  
        opcode = 6'b100110;  // A SRL B w. o. S
        A_in = 32'h00000001;
        B_in = 32'b00000001;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\tShowing register flags");
        $display("\t N Z C V ");
        $display("\t %b %b %b %b\n", N, Z, C, V);
      
      $display("\t============ SRA ===========");
      $display("\tTesting SHIFT RIGHT ARITHMETICALLY");  
        opcode = 6'b100111; // A SLA
        A_in = 32'h00000002;
        B_in = 32'b00000001;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\t\tShowing register flags");
        $display("\t\t N Z C V ");
        $display("\t\t %b %b %b %b\n", N, Z, C, V);
      
       $display("|---------- Testing ADD / SUB function -----------|");
       $display("\t============ ADD ===========");
       $display("\tTest #1 - Testing ADD w. o. S, w.o. carry");  
        opcode = 6'b000000; // A ADD by  B 
        A_in = 32'h00000001;
        B_in = 32'b00000001;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\t\tShowing register flags");
        $display("\t\t N Z C V ");
        $display("\t\t %b %b %b %b\n", N, Z, C, V);
      
       $display("\tTest #2 - Testing ADD with S w.o carry");  
        opcode = 6'b010000; // A ADD by  B 
        A_in = 32'h00000001;
        B_in = 32'b00000001;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\t\tShowing register flags");
        $display("\t\t N Z C V ");
        $display("\t\t %b %b %b %b\n", N, Z, C, V);
      
        $display("\tTest #3 ADD w. o. S, with carry");  
        opcode = 6'b001000; // A ADD by  B 
        A_in = 32'hffffffff;
        B_in = 32'h00000001;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\t\tShowing register flags");
        $display("\t\t N Z C V ");
        $display("\t\t %b %b %b %b\n", N, Z, C, V);
      
        $display("\tTest #4 ADD with S, with carry");  
        opcode = 6'b011000; // A ADD by  B 
        A_in = 32'hffffffff;
        B_in = 32'h00000001;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\t\tShowing register flags");
        $display("\t\t N Z C V ");
        $display("\t\t %b %b %b %b\n", N, Z, C, V);
      
       $display("\t===========SUBTRACT==========");
       $display("\t-----------------------------");
       $display("PLEASE NOTE THE CURRENT STATE OF THE STATUS REG");     
       $display("\tTest#1 SUB w.o. carry w. o. S");  
        opcode = 6'b000100;   
        A_in = 32'h00000001;
        B_in = 32'h00000002;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
               
        #100
        $display("\tShowing register flags");
        $display("\t\tN Z C V ");
        $display("\t\t%b %b %b %b\n", N, Z, C, V);
  
      $display("\tTest#2 SUB w.o. carry with S");  
        opcode = 6'b010100; // A SUB by B  
        A_in = 32'h00000001;
        B_in = 32'h00000002;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\tShowing register flags");
        $display("\t\t N Z C V ");
        $display("\t\t %b %b %b %b\n", N, Z, C, V);
      
        $display("\tTest#3 SUB with carry w.o. S");  
        opcode = 6'b001100; // A ADD by  B 
        A_in = 32'hefffffff;
        B_in = 32'hffffffff;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\t\tShowing register flags");
        $display("\t\t N Z C V ");
        $display("\t\t %b %b %b %b\n", N, Z, C, V);
      
        $display("\tTest#4 SUB with carry with S");  
        opcode = 6'b011100; // A ADD by  B 
        A_in = 32'hefffffff;
        B_in = 32'hffffffff;
        
        #100
        $display("\t>>>> Set >>>> ALU ENABLE-----|");
        ALUE = 1'b1;
        #100   
        $display ("\t Ain       Bin            opcode       result");
        $display ("\t%h   %h  \t%b  \t%h",A_in,B_in,opcode,result);
        #100 
        ALUE = 0'b0;
        
        #100
        $display("\t\tShowing register flags");
        $display("\t\t N Z C V ");
        $display("\t\t %b %b %b %b\n", N, Z, C, V);
      
    end
    
    //initial begin
        //$display ("\t Ain       Bin            opcode       result");
       // $monitor ("\t%h   %h    %b    %h",A_in,B_in,opcode,result);
   // end
endmodule
