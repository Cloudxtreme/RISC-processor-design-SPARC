/**************************************
* Module: RegisterWindow_Test
* Date:2014-09-27  
* Author: josediaz     
*
* Description: Register Window Test module
***************************************/
module  RegisterWindow_Test();
    reg [0:0] WE, WEX, BE3, BE2, BE1, Clk;
    reg [7:0] RE;
    reg [4:0] RA, RB;
    reg [31:0] AxIn, BxIn, in, GA, GB;
     
    wire [31:0] AxOut, BxOut, Aout, Bout; 
    
    parameter sim_time = 1000; 
     
    RegisterWindow regWindow(AxOut, BxOut, Aout, Bout, AxIn, BxIn, in, WEX, RA, RB, WE, BE3, BE2, BE1, RE, GA, GB, Clk);
    //(output [31:0] AxOut, BxOut, Aout, Bout, input [31:0] AxIn, BxIn, in, input WEx, input [4:0] RA, RB, input WE, BE3, BE2, BE1, input [7:0] RE, input [31:0] GA, GB, input Clk);
    initial #sim_time $finish;                  //simulation time
    initial begin
        in = 32'h00001111;
        RE[7] = 1'b1;
        
        BE3 = 1'b1;
        WE = 1'b1;
        Clk = 1'b1; //__/T
        
        #10 Clk = 1'b0;
        
        RA = 5'b11111;
        
      end
     initial begin
        $display ("Clk  BE3  RA[4:0]  WE    in     Aout     AxOut");
        $monitor (" %b   %b    %b      %b    %h %h %h", Clk, BE3, RA, WE, in, Aout, AxOut);
       end
 
endmodule

