/**************************************
* Module: decoder_2x4
* Date:2014-09-24  
* Author: dmoran     
*
* Description: 2x4 decoder to be used in register file
***************************************/
module  decoder_2x4(output reg[3:0] Y,input wire[1:0] s);
    always @(s)
    begin
        case (s)
            2'b00: Y = 4'h1;
            2'b01: Y = 4'h2;
            2'b10: Y = 4'h4;
            2'b11: Y = 4'h8;
        endcase
    end

endmodule

