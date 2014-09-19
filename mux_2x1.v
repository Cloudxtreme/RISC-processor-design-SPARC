/**************************************
* Module: mux_2x1
* Date:2014-09-07  
* Author: dmoran  & JDiaz   
*
* Conventions:
*    Y  -> Output
*    Ix -> Input 
*
* Description: mux 2x1
***************************************/
module  mux_2x1(output reg[31:0] Y,input wire[0:0] s, input wire[31:0] I1, I0);
    always @( s or I0 or I1)
    begin 
        case (s)
            1'b0: Y = I0;
            1'b1: Y = I1;
        endcase
    end
endmodule

