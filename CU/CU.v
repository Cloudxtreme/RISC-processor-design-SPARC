/**************************************
* Module: CU
* Date:2014-10-29  
* Author: josediaz     
*
* Description: brais brains brains
***************************************/
module  CU(output reg [0:0] IRE, MDRE, nPCE, PCE, MARE, nPC_ADD, tQE, tQClr, IRClr, nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, PSRE, BAUX, RFE, RA_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, ALUE, 
PSR_SUPER, PSR_PREV_SUP, ClrPC, nPCClr, PSR_SEL, TBA_SEL, output reg [31:0] MDR_AUX, MAR_AUX, WIM_IN, output [1:0] nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, MAR_SEL, MDR_SEL, output reg [4:0] CWP,
 output reg [5:0] OP1, output reg [24:0] TBA_IN, output reg [5:0] tQ_IN, input [31:0] IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, TQ, ALU, input [0:0] MFC, Clk, Reset);

    integer state = 0; 
    
    always @(posedge Clk)
     begin
        case (state)
            //reset 1
            0: begin
                IRE <= 1;
                MDRE <= 1; 
                TBRE <= 1;
                nPCE <= 1;
                PCE <= 1;
                MARE <= 1;
                tQE <= 1;
                nPC_ADD <= 0;
                nPC_ADDSEL <= 1;
                TB_ADD <= 0; 
                MFA <= 0; 
                MOP_SEL <= 1; 
                MAR_SEL <= 1;
                ClrPC <= 1;
                nPCClr <= 1;
                IRClr <= 1;
                nPC_SEL <= 1;
                PSRE <= 1;
                BAUX <= 0;
                RFE <= 1;
                ALUE <= 0;
                tQClr <= 1;
                RA_SEL <= 1;
                MDR_SEL <= 1;
                ALU_SEL <= 1;
                CIN_SEL <= 1;
                RC_SEL <= 1; 
                DISP_SEL <= 1;
                AOP_SEL <= 1;
                WIME <= 1;
                ttAUX <= 1;
                
                state = 1;
            end 
          1:   //reset2
            begin
                ClrPC <= 0;
                nPCClr <= 0;
                tQClr <= 0;
                IRClr <= 0;
                
                state  = 2;
           end
          2:  //reset3
            begin
                TBRE <= 0;
                nPC_ADDSEL <= 0;
                nPC_SEL <= 0;
                PSRE <= 0;
                RFE <= 0;
                RC_SEL <= 0;
                WIME <= 0;
                ClrPC <= 1;
                nPCClr <= 1;
                tQClr <= 1;
                IRClr <= 1;
                
                state = 3;
            end
           3:  //reset4
            begin 
                TBRE <= 1;
                nPCE  <= 0;
                nPC_ADD <= 1;
                PSRE <= 1;
                RFE <= 1;
                WIME <= 1;
                
                state = 4;
            end
          4: //reset5
            begin
                nPCE <= 1; 
                nPC_ADD <= 0;
                
                state = 5;
            end           
          5: //fetch1
            begin
                MARE = 0;
                MAR_AUX = 0;
                MAR_SEL = 2;
                
                state = 6;
            end 
          6: //fetch2
           begin
                MARE = 1;
                MOP_SEL = 1;
                MDR_SEL = 0;
                OP1 = 6'h08;
           
                state = 7;            
           end
          7: //fetch3
            begin
                MDRE = 0;
                MFA = 1;
                
                state = 8;
            end
          8: //fetch4
           begin
                IRE = 0;
                MFA = 0;
                MDRE = 1;
                
                state = 9;
           end  
          9: //fetch5
            begin
                IRE <= 1;
                
                state = 10;
            end  
          10: //decode op0
            begin
                if(IR[31:30] == 0)
                    state = 11;
                else if(IR[31:30] == 1)
                    state = 24;
                else if(IR[31:30] == 2)
                    state = 28;
                else state = 68;
            end
           11: //decode op3
            begin
                if(IR[24:22] == 4)
                    state = 12;
                else if(IR[24:22] == 2)
                    state = 15;
                else state = 84; 
            end
           12: //Set high1
            begin
               ALU_SEL = 3;
               CIN_SEL = 2;
               RC_SEL = 0;
               AOP_SEL = 1;
               OP1 = 6'b101010; //set high value
               
               state = 13;
            end 
           13: //Set high2
             begin
                RFE = 0;
                ALUE = 1;
                
                state = 14;
             end
           14://Set high3
             begin
               RFE = 1;
               ALUE = 0;
               
               state = 15;     
             end
           15: //branch1
            begin
                PCE = 0;
                
                state = 16;
            end
           16: //branch2
            begin
                PCE = 1;
                
                checkFlags;
            end 
           17: //branch t1
            begin
                nPC_SEL = 2;
                DISP_SEL = 0;
                
                state = 18;
            end
          18: //branch t2
           begin 
                nPCE = 0;
                BAUX = 1;
                
                state = 19;
           end
          19: //branch t3
           begin
                nPCE = 1;
                BAUX = 0;
                
                if(nPC > 508)
                 state = 84;
                else state = 90;
           end
          20: //branch F
           begin
                if(IR[29] == 1)
                 state = 21;
                else state = 86;
           end
          21: //branchF1
           begin
                nPC_ADDSEL = 1;
                nPC_SEL = 0;
                
                state =22;
           end 
         22: //branchF2
          begin
           nPCE = 0;
           nPC_ADD = 1;
           
           state = 23;
          end
         23: //branchF#
           begin
           nPCE = 1;
           nPC_ADD = 0;
    
           if(nPC > 508)
             state = 84;
            else state = 90;
                       
          end
         24://call1
          begin 
            RFE = 0;
            CIN_SEL = 1; 
            RC_SEL = 3;
                        
            state = 25;            
          end
         25: //call2
           begin 
            PCE = 0;
            nPC_SEL = 2;
            RFE = 1;            
            DISP_SEL = 1;        
                                   
            state = 26;            
          end
        26: //call3
          begin
            nPCE = 0;
            PCE = 1;
            BAUX = 1;
            
            state = 27;
          end
       27: //call4
        begin
            nPCE = 1;
            BAUX = 0;
            
            if(nPC > 508)
             state = 84;
            else state = 90;
        end
       28: // op 2.1
        begin
            if(IR[24:19] == 6'b111000)
             state = 29;
            else if(IR[24:19] == 6'b111001)
             state = 40;
            else if(IR[24:19] == 6'b111100 || IR[24:19] == 6'b111101)
             state = 51;
            else state = 60;
        end 
      29: //jmpl !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     end

    always @(posedge Reset)
     begin 
        state = 0;
     end
    
    //checks flags and sets state
     task checkFlags;
        begin
            
        end
     endtask
endmodule

