/**************************************
* Module: nPC_ADD_Test
* Date:2014-10-11  
* Author: josediaz     
*
* Description: testing nPC_Add
***************************************/
module  nPC_ADD_Test();

    reg [31:0] in;
    reg [0:0] sel,nPC_ADD;
    wire[31:0] out;
    
    nPC_ADD nPC_Add(out, in, sel, nPC_ADD);
                      //simulation time
    initial begin
     $display("|========= Testing tt_Aux ==========|");
        
        in = 5;
        sel = 1;
        #100
        nPC_ADD = 1;
        #100
        
        
        $display("\t Displaying out %d with sel = 1 ", out);
        
        #100
        sel = 0;
        #100
        nPC_ADD = 0;
        #100
        nPC_ADD = 1;
        
        #100
        $display("\t Displaying out %d with sel = 0", out);
        
      end

endmodule

