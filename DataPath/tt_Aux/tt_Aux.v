/**************************************
* Module: tt_Aux
* Date:2014-10-11  
* Author: josediaz     
*
* Description: Updater for the tt 
***************************************/
module  tt_Aux(output reg[7:0] out, input wire[31:0] aluOut, input ttAux);
 
 //11 a 4
 always@ (posedge ttAux)
  begin
  out = aluOut[31:0] + 128;
  end
endmodule

