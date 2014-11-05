/**************************************
* Module: branch_Aux
* Date:2014-10-11  
* Author: josediaz     
*
* Description: multiplies displacement by 4 and adds to PC
***************************************/
module  branch_Aux(output reg [31:0] out, input [31:0] in_pc, input [29:0] in_disp, input [0:0] BAUX, dispSel);
    
    
    reg [31:0] buff_true;
    reg [31:0] buffOut;
    reg [31:0] buff_false;
    
    reg [31:0] buff_sigEx;
    
always @( posedge BAUX)
 begin
          
    if(dispSel)
     begin //disp30
         buff_sigEx = in_disp;
         buff_sigEx = {{2{buff_sigEx[29]}},{buff_sigEx[29:0]}};
 
         buff_true = buff_sigEx;
         buff_true = in_disp * 4;
         out = buff_true + in_pc;
     end //{{24{ram[address][7]}}, ram[address]};
    else //disp22
     begin
         //buff_false = in_disp & 30'b000000001111111111111111111111; 
         buff_sigEx = in_disp; //buff_false
         buff_sigEx = {{8{buff_sigEx[21]}},{buff_sigEx[21:0]}};
         
         buff_false = buff_sigEx;
            
         //if(in_disp[21])
          //  begin
           //     buff_false = buff_false^22'hfffff;
            //    buff_false = buff_false + 1'b1;
             //   buffOut = buff_false * 4; 
              //  out = buffOut - in_pc;
            //end
        //else
          //  begin
        buffOut = buff_false * 4; 
        out = buffOut + in_pc;
           // end
    end
 
 end
endmodule

