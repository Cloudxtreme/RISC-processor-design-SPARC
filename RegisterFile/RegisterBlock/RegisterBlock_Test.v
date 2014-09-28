/**************************************
* Module: RegisterBlock_Test
* Date:2014-09-27  
* Author: josediaz     
*
* Description: RegisterBlock test module
***************************************/
module  RegisterBlock_Test();
    reg [0:0] BE, R7E, R6E, R5E, R4E, R3E, R2E, R1E, R0E, Clk;
    reg [31:0] in;
    reg [2:0] RA, RB;
    wire [31:0] Aout, Bout;
    
    parameter sim_time = 1000; 
     
    register_block_32bit regBlock(Aout, Bout, in, BE, R7E, R6E, R5E, R4E, R3E, R2E, R1E, R0E, RA, RB, Clk);
    initial #sim_time $finish;                  //simulation time
    initial begin
        //write on R7 the hex number 00001111
        Clk = 1'b1; // __/T
        BE = 1'b1;
        R7E = 1'b1; 
        
        in = 32'h00001111;
        repeat (1) #10 
            begin 
                Clk = 1'b0; // T\__
                BE = 1'b0;
            end
        repeat (1) #10 Clk<=1'b1; // ___/T  
        RA = 3'b111;
              
    end
    initial begin
        $display ("R7E  BE  RA[2:0] Clk  In  Aout");
        $monitor (" %b   %b  %b  %b %h %h", R7E, BE, RA, Clk, in, Aout);
    end

endmodule

