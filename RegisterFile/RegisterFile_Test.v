/**************************************
* Module: RegisterFile_Test
* Date:2014-09-28  
* Author: josediaz     
*
* Description: Register File Tester
***************************************/
module  RegisterFile_Test();
    
    reg [4:0] RA, RB, RC;
    reg [0:0] RFE, Clk;
    reg [1:0] CWP;
    reg [31:0] Rin;
    
    wire [31:0] Aout, Bout;
    
    parameter sim_time = 1000; 
    
    RegisterFile regFile(Aout, Bout, Rin, CWP, RA, RB, RC, RFE, Clk);
//RegisterFile(output reg [31:0] Aout, Bout, input [31:0] Rin, input [1:0] CWP, input [4:0] RA, RB, RC, input RFE, Clk);
    
    initial #sim_time $finish;                  //simulation time
    initial begin
     $display("|------- Test #1 ---------|");
        Rin = 32'h00001111;
        RC = 5'b00000;
        #100
        $display("\tWriting %h to R0", Rin);
        Clk = 1'b1; //__/T
        #100 Clk = 1'b0;
        RA = 5'b00000;
        CWP = 2'b00;
        #100
        $display("\treading R0: %h", Aout);
        
    $display("|------- Test #2 ---------|");
        CWP = 2'b01;
        RC = 5'b11101;
        $display("\tWriting %h to R29 of W1", Rin);
        #100
        Clk = 1'b1; //__/T
        #100 Clk = 1'b0;
        CWP = 2'b10;
        RB = 5'b01101;
        #100
        $display("\tReading R13 of W2: %h ",Bout);
      end
 //    initial begin
  //      $display ("Rin  BE3  RA[4:0]  WE    in     Aout     AxOut");
    //    $monitor (" %b   %b    %b      %b    %h %h %h", Clk, BE3, RA, WE, in, Aout, AxOut);
//       end
 

endmodule

