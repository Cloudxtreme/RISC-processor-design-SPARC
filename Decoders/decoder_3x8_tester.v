/**************************************
* Module: decoder_3x8_tester
* Date:2014-09-24  
* Author: dmoran     
*
* Description: teting module for decoder 3x8
***************************************/
module  decoder_3x8_tester;
    
    reg [2:0] s;
    wire [7:0]Y;
    
    parameter sim_time = 100;                   //simulation time
    decoder_3x8 dec1 (Y, s); //syntax for instanciation
    initial #sim_time $finish;                  //simulation time
    initial begin
       
        
        s = 3'b000;
        repeat (7) #10 s = s + 3'b001;
    end
    initial begin
        $display (" S     Y");
        $monitor (" %b   %b",s,Y);
    end


endmodule

