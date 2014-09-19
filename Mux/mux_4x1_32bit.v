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
module  mux_4x1_32bit(output reg[31:0] Y,input wire[1:0] s, input wire[31:0] I3, I2, I1, I0);
    always @( s or I3 or I2 or I0 or I1)
    begin 
        case (s)
            2'b00: Y = I0;
            2'b01: Y = I1;
            2'b10: Y = I2;
            2'b11: Y = I3;
        endcase
    end
endmodule

