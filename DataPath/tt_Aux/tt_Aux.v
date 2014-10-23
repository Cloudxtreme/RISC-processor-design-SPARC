/**************************************
* Module: tt_Aux
* Date:2014-10-11  
* Author: josediaz     
*
* Description: Updater for the tt 
***************************************/
module  tt_Aux(output reg[2:0] out, input wire[5:0] tQout, input ttAux);
 
 //11 a 4
always@ (ttAux)
begin
    if(tQout & 6'b000001)
    begin
            out = 0;
    end
    else if(tQout & 6'b000010)
    begin
        out = 1;
    end
    else if(tQout & 6'b000100)
    begin
        out = 2;
    end
    else if(tQout & 6'b001000)
    begin
        out = 3;
    end
    else if(tQout & 6'b010000)
    begin
        out = 4;
    end
    else if(tQout & 6'b100000)
    begin
        out = 5;
    end
end
endmodule

