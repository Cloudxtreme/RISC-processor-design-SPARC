/**************************************
* Module: registr_32bit_le_aclr
* Date:2014-09-07  
* Author: dmoran  & JDiaz   
*
* Conventions:
* 
* Description: register 32bit with load enable and asynchronous clear
* active low enable
***************************************/
module register_32bit_le_aclr(output reg[31:0] Y, input wire[31:0] I0, input wire[0:0] loadE, Clr, Clk);

always @(negedge Clr, posedge Clk)
 begin
    if(!Clr) Y <= 32'h00000000;
    else if(!loadE && Clk==1) Y <= I0;
 end

endmodule
