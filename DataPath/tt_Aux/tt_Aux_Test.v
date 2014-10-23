/**************************************
* Module: tt_Aux_Test
* Date:2014-10-11  
* Author: josediaz     
*
* Description: Testing tt_Aux
***************************************/
module  tt_Aux_Test();

    reg [5:0] in;
    reg [0:0] sig;
    wire[2:0] out;
    
    tt_Aux ttAux(out, in, sig);
                      
    initial begin
     $display("|========= Testing tt_Aux ==========|");
       
       in = 6'b001000;
       #10
       sig = 1;
       #10
       sig = 0;
       $display("in=%b    out=%d",in, out);
       #10
       in = 2;
       #10 sig = 1;
       #10 sig = 0;
        $display("in=%b    out=%d",in, out);
        
        
        #10
       in = 34;
       #10 sig = 1;
       #10 sig = 0;
        $display("in=%b    out=%d",in, out);
        
       
        
      end



endmodule

