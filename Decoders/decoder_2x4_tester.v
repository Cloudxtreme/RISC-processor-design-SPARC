/**************************************
* Module: decoder_2x4_tester
* Date:2014-09-24  
* Author: dmoran     
*
* Description: Testing Module for decoder 2x4
***************************************/
module  decoder_2x4_tester;
    reg [1:0] s;
    wire [3:0]Y;
    
    parameter sim_time = 100;                   //simulation time
    decoder_2x4 dec1 (Y, s); //syntax for instanciation
    initial #sim_time $finish;                  //simulation time
    initial begin
       
        
        s = 2'b00;
        repeat (3) #10 s = s + 2'b01;
    end
    initial begin
        $display (" S    Y");
        $monitor (" %b   %b",s,Y);
    end


endmodule

