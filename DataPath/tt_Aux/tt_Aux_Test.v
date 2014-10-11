/**************************************
* Module: tt_Aux_Test
* Date:2014-10-11  
* Author: josediaz     
*
* Description: Testing tt_Aux
***************************************/
module  tt_Aux_Test();

    reg [31:0] in;
    reg [0:0] sig;
    wire[7:0] out;
    
    tt_Aux ttAux(out, in, sig);
                      //simulation time
    initial begin
     $display("|========= Testing tt_Aux ==========|");
        
        in = 5;
        #100
        sig = 1;
        #100
        
        $display("\t Displaying in %d", in);
        $display("\t Displaying out %d", out);
        
      end



endmodule

