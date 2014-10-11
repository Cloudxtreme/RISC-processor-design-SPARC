/**************************************
* Module: nPC_ADD
* Date:2014-10-11  
* Author: josediaz     
*
* Description: increments the value of PC
***************************************/
module  nPC_ADD(output reg [31:0] out, input [31:0] pc, input [0:0] Sel, nPC_ADD);

always @(posedge nPC_ADD)
 begin
 
    if(Sel)
     begin
     out = pc + 8;
     end
    else
     begin
     out = pc + 4; 
     end
 
 end
endmodule

