/**************************************
* Module: TB_ADD_Test
* Date:2014-10-11  
* Author: josediaz     
*
* Description: testing TB_ADD
***************************************/
module  TB_ADD_Test();
    
    reg [31:0] in;
    reg [0:0] sig;
    wire[31:0] out;
    
    reg [19:0] tba;
    reg [7:0] tt;
    
    
    TB_ADD tbadder(out, in, sig);
                      //simulation time
    initial begin
     $display("|========= Testing TB_ADD ==========|");
        
        in = 32'h00010070;
        #100
        sig = 1;
        #100
        tba = in[31:12];
        tt = in[11:4];
        
        $display("\t Display tba:%d \ttt:%d ", tba, tt);
        $display("\t Display ",in);
        $display("\t Displaying out %d", out);
        
      end

endmodule

