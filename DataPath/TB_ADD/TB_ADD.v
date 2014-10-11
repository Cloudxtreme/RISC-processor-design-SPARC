/**************************************
* Module: TB_ADD
* Date:2014-10-11  
* Author: josediaz     
*
* Description: Adds trap base address with tt 
***************************************/
module  TB_ADD(output reg[31:0] out, input wire[31:0] x, input TB_ADD);
 
 //11 a 4
 always@ (posedge TB_ADD)
  begin
  out = x[31:12] + x[11:4];
  end
endmodule

