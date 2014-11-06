/**************************************
* Module: CU
* Date:2014-10-29  
* Author: josediaz     
*
* Description: brais brains brains
***************************************/
module  CU(output reg [0:0] IRE, TBRE, MDRE, nPCE, PCE, MARE, nPC_ADD, tQE, tQClr, IRClr, nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, PSRE, BAUX, RFE, RA_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, ALUE, 
PSR_SUPER, PSR_PREV_SUP, ClrPC, nPCClr, output reg [31:0] MDR_AUX, MAR_AUX, WIM_IN, output reg [1:0] nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, MAR_SEL, MDR_SEL, PSR_SEL, TBA_SEL, output reg [4:0] CWP,
 output reg [5:0] OP1, output reg [24:0] TBA_IN, output reg [5:0] tQ_IN, input [31:0] IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, TQ, ALU, input [0:0] MFC, Clk, Reset);
    integer cond = 0;
    integer overC,underC;
    integer state = 0; 
    reg[4:0] CWP_local; 
    
    always @(posedge Clk)
     begin
    // $display("state: %d;\tPC: %h;\tnPC: %h", state, PC, nPC);
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
                CWP <= 1;
                PSR_SUPER <= 0;
                PSR_PREV_SUP <= 0;
                ET <= 1;
                
                state = 1;
            end 
          1:   //reset2
            begin
                ClrPC = 0;
                nPCClr = 0;
                tQClr = 0;
                IRClr = 0;
                TBA_SEL = 1;
                PSR_SEL = 1;
                TBA_IN = 3;
        
                state  = 2;
           end
          2:  //reset3
            begin
                TBRE <= 0;
                nPC_ADDSEL = 0;
                nPC_SEL = 0;
                PSRE = 0;
                RFE = 0;
                RC_SEL = 0;
                WIME = 0;
                ClrPC = 1;
                nPCClr = 1;
                tQClr = 1;
                IRClr = 1;
                
                state = 3;
            end
           3:  //reset4
            begin 
                TBRE = 1;
                nPCE  = 0;
                nPC_ADD = 1;
                PSRE = 1;
                RFE = 1;
                WIME = 1;
                TBA_SEL = 0;
                PSR_SEL = 0;
                state = 4;
            end
          4: //reset5
            begin
                nPCE = 1; 
                nPC_ADD = 0;
                
                state = 5;
            end           
          5: //fetch1
            begin
                MARE = 0;
                MAR_AUX = 0;
                MAR_SEL = 1;
                $display("Fetch");
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
                
                if(MFC == 1)
                    state = 8;
                else state = 7;
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
                IRE = 1;
                
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
                    state = 110;
                else state = 84; 
            end
           12: //Set high1
            begin
               ALU_SEL = 3;
               CIN_SEL = 2;
               RC_SEL = 0;
               AOP_SEL = 1;
               OP1 = 6'b101010; //set high value
               DISP_SEL = 0;//
               BAUX = 1;//testing changes
               $display("sethi");
               state = 13;
            end 
           13: //Set high2
             begin
                RFE = 0;
                ALUE = 1;
                BAUX = 0;//testing changes
                state = 14;
             end
           14://Set high3
             begin
               RFE = 1;
               ALUE = 0;
               
               state = 86;     
             end
           15: //branch1
            begin
                //PCE = 0;
                $display("branch");                                 
                DISP_SEL = 0;                                       //|\\
                BAUX = 1;
                state = 16;
            end
           16: //branch2
            begin
                BAUX = 0;
                cond = 0;
            checkFlags;  
            if(cond)
                state = 17;
            else
                state = 20;
                checkFlags;
            end 
           17: //branch t1
            begin
                PCE = 0;
                nPC_SEL = 2;
                state = 18;
            end
          18: //branch t2
           begin 
                PCE = 1;
                nPCE = 0;
                
                state = 19;
           end
          19: //branch t3
           begin
                nPCE = 1;
                
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
                PCE = 0;
                state = 22;
           end 
         22: //branchF2
          begin
           PCE = 1;
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
            $display("call"); 
            DISP_SEL = 1; 
            BAUX = 1;          
            state = 25;            
          end
         25: //call2
           begin 
            PCE = 0;
            nPC_SEL = 2;
            RFE = 1;            
            BAUX = 0;
                    
                                   
            state = 26;            
          end
        26: //call3
          begin
            nPCE = 0;
            PCE = 1;
            //BAUX = 1;
            
            state = 27;
          end
       27: //call4
        begin
            nPCE = 1;
            //BAUX = 0;
            
            //check valid address
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
            else if(IR[24:19] == 6'b111010)
             state = 65;
            else if(IR[24:19] == 6'b110001)
             state = 101;//WRTPSR
            else if(IR[24:19] == 6'b110010)
             state = 0;//WRTWIM
            else if(IR[24:19] == 6'b110011)
             state = 0;//WRTTBR
            else state = 60;
        end 
      29: //jmpl !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        begin
            RFE = 0;
            CIN_SEL = 1;
            RC_SEL = 0;
            $display("jmpl");
            state = 30;
        end
      30: //jmpl 2
        begin
            PCE = 0;
            RFE = 1;
            
            state = 31;
        end
       31: //jmpl 3
        begin
            PCE = 1;
            nPC_SEL = 3;
            RA_SEL = 0;
            AOP_SEL = 1;
            OP1 = 6'b000000;
            
            if(IR[13] == 1)
                state = 36;
            else state = 35;
          end
        35: //jmpl R
            begin
             ALU_SEL = 0;
             
             state = 37;
            end
        36: //jmpl D
          begin
            ALU_SEL = 1;
            
            state = 37;
          end 
        37: //jmpl 4
            begin
             nPCE = 0;
             ALUE = 1;
             
             state = 39;               
            end
        39: //jmpl 5
         begin
            nPCE = 1;
            ALUE = 0;
            //check valid address
            if(nPC > 508)
             state = 84;
            else state = 90;                
         end
        40: //ret1
         begin
            underC = 0;
            checkUnderFlow;
            $display("rett");
            if(underC)
                state = 41;
            else
                state = 43;
         end
        41: //ret trap1
         begin
            tQ_IN[2] = 1;
            tQE = 0;
            
            state = 42;
         end
       42: //ret trap 2 
         begin
            tQE = 1;
            
            state = 90;
         end
      43: //ret 2
        begin
            PSR_SUPER = PSR_PREV_SUP;
            CWP = CWP + 1;
            ET = 1;
                                        
            state = 44;
        end
      44: //ret 3
        begin
            PCE = 0;
            PSRE = 0;
            
            state = 45;
        end
      45: //ret4
        begin
            PCE = 1;
            PSRE = 1;
            
            nPC_SEL = 3;
            RA_SEL = 0;
            AOP_SEL = 1;
            OP1 = 6'b000000;
            
            if(IR[13] == 1)
                state = 47;
            else state = 46;
        end
      46: //ret R
       begin
            ALU_SEL = 0;
            
            state = 48;
       end
      47: //ret D
       begin
            ALU_SEL = 1;
            
            state = 48;
       end 
      48: //ret 5
       begin
            nPCE = 0;
            ALUE = 1;
            CIN_SEL = 1;
            RC_SEL = 0;
            
            state = 49;
       end 
      49: //ret 6
       begin
            nPCE = 1;
            RFE = 0;
            ALUE = 0;
            
            state = 50;
       end
      50: //ret 7
       begin
            RFE = 1;
             //check valid address
            if(nPC > 508)
             state = 84;
            else state = 90;
       end
      51: //SR1
       begin
           underC = 0;
           overC = 0;
           checkUnderFlow;
           checkOverFlow;
           $display("save/restore");
           if(underC || overC)
            state = 52;
           else
            state = 54;
       end
      52: //SR TRAP1
       begin
            
           if(underC)
                tQ_IN[2] = 1;
           else if(overC)
                tQ_IN[1] = 1;
           
           tQE = 0;
           state = 53;
       end
     53: //SR TRAP2
      begin
           tQE = 1;
           
           state = 90;
      end
     54: //SR 2  
      begin
            if(IR[24:19] == 6'b111100)
                CWP = CWP - 1;     
            else CWP = CWP + 1;
            
            PSRE = 0;
            
            state = 55;
      end
     55: //SR 3
      begin
            PSRE = 1;
            CIN_SEL = 2;
            RC_SEL = 0;
            AOP_SEL = 1;
            OP1 = 6'b000000;
            
            if(IR[13] == 1)
                state = 57;
            else state = 56;  
      end 
     56: //SR R 
      begin
        ALU_SEL = 0;
        
        state = 58;
      end
     57: //SR D 
      begin
        ALU_SEL = 1;
        
        state = 58;
      end
     58: //SR 4
        begin
            RFE = 0;
            ALUE = 1;
        
            state = 59;
        end
     59: //SR 5
        begin
            RFE = 1;
            ALUE = 0;
        
            state = 86;
        end
     60: //ALOP 1   
      begin
            RA_SEL = 0;
            CIN_SEL = 2;
            RC_SEL = 0;
            AOP_SEL = 0;
            $display("alop");
            if(IR[13] == 1)
                state = 62;
            else state = 61;
      end
     61: //ALOP R
        begin
            ALU_SEL = 0;
            $display("Performing Arithmetic operation rd=%d, rs1=%d, rs2=%d",IR[29:25],IR[18:14],IR[4:0]);
            state = 63;
        end
     62: //ALOP D
        begin
            ALU_SEL = 1;
            $display("Performing Arithmetic operation rd=%d, rs1=%d, rs2=%d",IR[29:25],IR[18:14],IR[4:0]);
            state = 63;
        end
     63: //ALOP2
        begin
            RFE = 0;
            ALUE = 1;
            
            state = 64;
        end
     64: //ALOP3   
        begin
            RFE = 1;
            ALUE = 0;
            //$display("result = %d",ALU);
            state = 86;
        end
     65: //TRAP 1
        begin
            cond = 0;
            checkFlags; 
            $display("cond trap"); 
            if(cond)
                state = 66;
            else
                state = 86;  
        end
     66: //TRAP 2
        begin
            tQ_IN[3] = 1;
            tQE = 0;
            state = 67;
        end
      67: //TRAP 3
       begin
            tQE = 1;
             
            state = 86; 
       end
      68: //LS1
       begin
            MAR_SEL = 0;
            RA_SEL = 0;
            AOP_SEL = 1;
            OP1 = 6'b000000;
            $display("load/store");
            if(IR[13] == 1)
                state = 70;
            else state = 69;  
       end
      69: //LS R
       begin
        ALU_SEL =0;
        
        state = 71;
       end
      70: //LS D
        begin
         ALU_SEL = 1;
         
         state = 71;
        end 
      71: //LS2 
       begin
        MARE = 0;
        ALUE = 1;
        
        state = 72;
       end
      72: //LS3
        begin
         MARE = 1;
         ALUE = 0;

           //check valid address
            if(nPC > 508) //BAD
             state = 84;
            else state = 73; //GOOD       
        end
      73: //LS4
       begin
         if(IR[21] == 1)
            state = 79;
         else state = 74;
       end 
      74: //LOAD1
       begin
         MOP_SEL = 0;
         MDR_SEL = 0;
         $display("load");
         CIN_SEL = 3;
            RC_SEL = 0;
         state = 75;
       end
     75: //LOAD2
        begin
         MDRE = 0;
         MFA = 1;
         
         state = 76; 
        end
      76: //LOAD3
             begin
                if(MFC == 1)
                state = 77;
             else state = 76; 
         end 
       77: //LOAD4
        begin
            MDRE = 1;
            RFE = 0;
            #100
            //CIN_SEL = 3;
            //RC_SEL = 0;
           // $display("loading value %d",MDR);
           // $display("from: %h",MAR);
            state = 78;
        end
      78: //LOAD5
        begin
            #100
            RFE = 1;
            
            state = 86;
        end
      79: //STORE1
        begin
            MDRE = 0;
            RA_SEL= 1;
            MDR_SEL =1;
            $display("store");
            state = 80;
        end  
       80: //STORE2
        begin
            MDRE = 1;
            MOP_SEL = 0;
            
            state = 81;
        end 
       81: //STORE3
        begin
            MFA = 1;
            
            state = 82;
        end 
       82: //STORE4
        begin
         if(MFC == 1)
            state = 83;
         else state = 82;
        end 
       83: //STORE5
        begin
         MFA = 0;
         
         state = 86;
        end
       84: //invalid instruction 1
        begin
         tQ_IN[5] = 1; //VERIFYYYYYYY
         tQE = 0;
         $display("invalid instruction");
         state = 85;
        end
       85: //invalid instruction 2
        begin
         tQE = 1;
         
         state = 90;
        end 
       86: //nPC update 1
        begin
         PCE = 0;
         MOP_SEL = 1;
         OP1 = 6'h08;
         MAR_SEL = 1;
         MDR_SEL = 0;
         $display("nPCupdate");
         state = 87; 
        end 
       87: //nPC update 2
        begin
          PCE = 1;
          nPC_ADDSEL = 0;
           nPC_SEL = 0;
           MARE = 0;
           state = 88;
        end 
       88: //nPC update 3 
        begin
         nPC_ADD = 1;
         nPCE = 0;
         MARE = 1;
         state = 89;
        end
       89: //nPC update 4
        begin
            nPCE = 1;
            nPC_ADD = 0;
            
            state = 90;
        end
       90: //ELLLLL FAMOSOOOOOOOO
        begin
        $display("trapQ");
          if(TQ[5:0] == 0)
           state = 5;
          else state = 91;
        end 
       91: // Trap Queue1
        begin
            PSR_SEL = 1;
            PSRE = 0;
            PSR_SUPER = 1;
            PSR_PREV_SUP = 0;
            ET = 0;
            CWP = 0;
            RFE = 0;
            CIN_SEL = 0;
            RC_SEL = 2;
            
            state = 92;
        end
       92: // Trap Queue2
        begin
            PSRE = 1;
            PSR_SEL = 0;
            RFE = 1;
            
            state = 93;
        end
       93: // Trap Queue3
        begin
            RFE = 0;
            CIN_SEL = 1;
            RC_SEL = 1;
            nPC_SEL = 1;
            
            state = 94;
        end
       94: //Trap queue4
         begin
             nPCE = 0;
             RFE = 1;
             TBRE = 0;
             ttAUX = 1;
             
             state = 95;
         end      
       95: //Trap queue5
        begin
            TBRE =0;
            nPCE = 1;
            ttAUX =0;
            
            state = 96;
        end      
       96: //Trap Queue6
        begin
            nPC_ADDSEL = 0;
            nPC_SEL = 1;
            
            state = 97;
        end 
       97: //Trap Queue7 
        begin
            TBRE = 1;
            nPCE = 0;
            
            state = 98;
        end 
      98: //Trap Queue8
       begin
            nPCE = 1;
            PCE = 0;
            
            state = 99;
       end 
      99: //Trap Queue9  
        begin
            nPC_ADD = 1;
            nPCE = 0;
            PCE = 1;
            tQ_IN  = 0;
            tQE = 0;
            state = 100;
        end
      100: //Trap Queue10
       begin
            nPC_ADD = 0;
            nPCE = 1;
            tQE = 1;
            state = 5;
       end
      
     101: //WRTPSR/TBR/WIM1 
      begin
            
            CIN_SEL = 2;
            RC_SEL = 0;
            AOP_SEL = 1;
            OP1 = 6'b000011;
            
            if(IR[13] == 1)
                state = 103;
            else state = 102;  
      end 
     102: //SR R 
      begin
        ALU_SEL = 0;
        
        state = 104;
      end
     103: //SR D 
      begin
        ALU_SEL = 1;
        
        state = 104;
      end
     104: //SR 4
        begin
             if(IR[24:19] == 6'b110001)
              begin
                PSRE = 0;//WRTPSR
                PSR_SEL = 1;
                $display("WRTPSR");
              end
            else if(IR[24:19] == 6'b110010)
              begin
                WIME = 0;//WRTWIM
                $display("WRTWIM");
              end
            else if(IR[24:19] == 6'b110011)
              begin
                TBRE = 0;//WRTTBR
                TBA_SEL = 1;
                $display("WRTTBR");
              end
            ALUE = 1;
        
            state = 105;
        end
     105: //SR 5
        begin
            PSRE = 1;
            PSR_SEL = 0;
            TBRE = 1;
            TBA_SEL = 0;
            WIME = 1;
            ALUE = 0;
        
            state = 86;
        end
       110: //branch new
       begin
        $display("branch");   
         DISP_SEL = 0;
         BAUX = 1;
         
         state = 111;   
       end
     111: //branch new 2
        begin
         BAUX = 0;
         cond = 0;
         checkFlags;
         if(cond)
           state = 112; 
         else state = 20;
          // state = 116;  
       end
     112:  //branch new true1
        begin
            PCE = 0;
            
            state = 113;
        end
     113:   //branch new true2
        begin
            PCE = 1;
            nPC_SEL = 2;
            
            state = 114;
        end
     114: //branch new true3
      begin
            nPCE = 0;
            
            state = 115;
      end
      115: //branch new true4
        begin
            nPCE = 1;
            
            state = 90;
        end  
   
     endcase
    end

    always @(posedge Reset)
     begin 
        state = 0;
     end
    
    //checks flags and sets state
     task checkFlags;
        begin
            case (IR[28:25])
                8:
                    begin
                        cond = 1;
                    end
                0:
                    begin
                        cond = 0;
                    end
                9:
                    begin
                        cond = !PSR[22];
                    end
                1:
                    begin
                        cond = PSR[22];
                    end
                10:
                    begin
                        cond = !(PSR[22] | (PSR[23] ^ PSR[21]));
                    end
                2:
                    begin//Z or (N xor V)!
                        cond = (PSR[22] | (PSR[23] ^ PSR[21]));
                    end
                11:
                    begin//not (N xor V)
                        cond = !(PSR[23] ^ PSR[21]);
                    end
                3:
                    begin
                        cond = (PSR[23] ^ PSR[21]);
                    end
                12:
                    begin
                        cond = !(PSR[20] | PSR[22]);
                    end
                4:
                    begin
                        cond = (PSR[20] | PSR[22]);
                    end
                13:
                    begin
                        cond = !PSR[20];
                    end
               5:
                    begin
                        cond = PSR[20];
                    end
                14:
                    begin
                        cond = !PSR[23];
                    end
               6:
                    begin
                        cond = PSR[23];
                    end
                15:
                    begin
                        cond = !PSR[21];
                    end
                7:
                    begin
                        cond = PSR[21];
                    end
            endcase
                    
        end
     endtask
     
     //checkUnderFlow
     task checkUnderFlow;
        begin
        //check if no trap state 41 
        underC = WIM[(CWP+1)%32];
        
        end
     endtask
     
     //checkOverFlow
     task checkOverFlow;
        begin
        overC = WIM[(CWP-1)%32];
        end
     endtask
endmodule

