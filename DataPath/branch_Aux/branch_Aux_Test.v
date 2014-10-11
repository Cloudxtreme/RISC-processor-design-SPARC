/**************************************
* Module: branch_Aux_Test
* Date:2014-10-11  
* Author: josediaz     
*
* Description: tests BAUX
***************************************/
module  branch_Aux_Test();

    reg [31:0] in_pc; 
    reg [29:0] in_disp;
    reg [0:0] sel,BAUX;
    wire[31:0] out;
    
    branch_Aux branch_Auxz(out, in_pc, in_disp, BAUX, sel);
                      //simulation time
    initial begin
     $display("|========= Testing branch_Aux ==========|");
        in_pc = 5;
        in_disp = 30'h10000000;
        
        #100
        sel = 1;
        
        $display("\t in_pc: %d\t in_disp: %d", in_pc, in_disp);
        #100
        BAUX = 1;
        #1000
        $display("\t Displaying out %d with sel = 1 ", out);
        
        #100
        BAUX = 0;
        #100
        sel = 0;
        #100
        
    
        BAUX = 1; 
        #100        
        BAUX = 0;
        #100
        
        $display("\t Displaying out %d with sel = 0", out);
        
      end

endmodule

