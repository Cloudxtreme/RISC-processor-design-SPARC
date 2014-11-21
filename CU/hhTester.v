/**************************************
* Module: CU_tester
* Date:2014-10-30  
* Author: josediaz     
*
* Description: 
***************************************/
module  CU_tester(
);


 integer i;
    reg [7:0] buffer[0:223];
    wire [31:0] IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, TQ,ALU;
    wire [0:0] MFC;
    wire [0:0] IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD,tQE,tQClr, IRClr, 
    nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, PSRE, BAUX, 
    RFE, RA_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, ALUE,
    PSR_SUPER, PSR_PREV_SUP, ClrPC, nPCClr;
    wire [31:0] MDR_AUX, MAR_AUX;
    wire [1:0] nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, MAR_SEL, MDR_SEL, PSR_SEL, TBA_SEL;
    wire [4:0] CWP;
    wire [5:0] OP1;
    wire [24:0] TBA_IN;
    wire [5:0] tQ_IN;
    wire [31:0] WIM_IN;
    
    reg [0:0] Clk, Reset;

DataPathV5 path(IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, TQ, ALU,
                     MFC, IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD,tQE,tQClr, IRClr, 
                    nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, PSRE, BAUX, 
                    RFE, RA_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, ALUE,
                    PSR_SUPER, PSR_PREV_SUP, ClrPC, Clk, nPCClr,MDR_AUX,MAR_AUX,
                    nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, MAR_SEL, MDR_SEL, PSR_SEL, TBA_SEL,
                    CWP,OP1, TBA_IN,
                     tQ_IN, WIM_IN);

CU cu(IRE, TBRE, MDRE, nPCE, PCE, MARE, nPC_ADD, tQE, tQClr, IRClr, nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, PSRE, BAUX, RFE, RA_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, ALUE, 
PSR_SUPER, PSR_PREV_SUP, ClrPC, nPCClr, MDR_AUX, MAR_AUX, WIM_IN, nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, MAR_SEL, MDR_SEL, PSR_SEL, TBA_SEL, CWP,
 OP1, TBA_IN, tQ_IN, IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, TQ, ALU, MFC, Clk, Reset);


 initial begin               //simulation time
//        ram.ram[0] = 8'h9C;
//        ram.ram[1] = 8'h04;
//        ram.ram[2] = 8'h40;
//        ram.ram[3] = 8'h12;
//        
        i = 0;
//        $readmemh("file.dat",buffer);
//        $display("  Preloading memory from file");
//        MOP_SEL  = 1;
//        MDR_SEL = 2;
//        
//        MDR_AUX = 32'hA2044012;
//        OP1 = 6'h04;
//        MDRE = 1;
//        #100 MDRE  = 0;
//        #30 Clk = 0;
//        #30 Clk =1;
//        #100 Clk <=0;
//        MDRE = 1;
//        #100
//        MFA = 1;
//        #500
//        MFA = 0;

      i = 0;
        $readmemb("testcode_sparc2.txt",buffer);
        $display("  Preloading memory from file");
        for(i=0;i<224;i=i+1)begin
            path.ram1.ram[i] = buffer[i[7:0]];
        end
        //path.registerFile.regWin1.block2.reg1.Y = 5;
        //path.registerFile.regWin1.block2.reg2.Y = 0;
          
        #500
        Reset = 0;
        #500
        Reset = 1;  
        #500   
        //==================
        // crap test from here on
      $display("***************************Test Start*******************************");
      //$display("ALU:\t\tPC:\t\tIR:\t\t\n");
      repeat(880) 
       begin
        #500
        Clk = 0;
        #500
        Clk = 1;
        //$display("%h\t%h\t%h\t%h\t%h", ALU, PC, IR, MAR, MDR);
       end  
      //$display("ALU:\t\tPC:\t\tIR:\t\t\n"); 
      //$monitor("%h\t%h\t%h\t", ALU, PC, IR); 
      
      $display("***************************Test Done*******************************\n");
      $writememb("ram_output.txt",path.ram1.ram);
      $writememh("ram_outputHEX.txt",path.ram1.ram);
      $display("RAM output:");
      for(i=0;i<260;i=i+4)begin
            $display("%d:   %h %h %h %h",i[15:0],path.ram1.ram[i],path.ram1.ram[i+1],path.ram1.ram[i+2],path.ram1.ram[i+3]);
        end
      
      $display("Current Register Window content:");
      
            $display("\tR0 = %d",path.registerFile.global.reg0.Y);
            $display("\tR1 = %d",path.registerFile.global.reg1.Y);
            $display("\tR2 = %d",path.registerFile.global.reg2.Y);
            $display("\tR3 = %d",path.registerFile.global.reg3.Y);
            $display("\tR4 = %d",path.registerFile.global.reg4.Y);
            $display("\tR5 = %d",path.registerFile.global.reg5.Y);
            $display("\tR6 = %d",path.registerFile.global.reg6.Y);
            $display("\tR7 = %d",path.registerFile.global.reg7.Y);
            $display("\tR8 = %d",path.registerFile.regWin0.block3.reg0.Y);
            $display("\tR9 = %d",path.registerFile.regWin0.block3.reg1.Y);
            $display("\tR10 = %d",path.registerFile.regWin0.block3.reg2.Y);
            $display("\tR11 = %d",path.registerFile.regWin0.block3.reg3.Y);
            $display("\tR12 = %d",path.registerFile.regWin0.block3.reg4.Y);
            $display("\tR13 = %d",path.registerFile.regWin0.block3.reg5.Y);
            $display("\tR14 = %d",path.registerFile.regWin0.block3.reg6.Y);
            $display("\tR15 = %d",path.registerFile.regWin0.block3.reg7.Y);
            $display("\tR16 = %d",path.registerFile.regWin1.block2.reg0.Y);
            $display("\tR17 = %d",path.registerFile.regWin1.block2.reg1.Y);
            $display("\tR18 = %d",path.registerFile.regWin1.block2.reg2.Y);
            $display("\tR19 = %d",path.registerFile.regWin1.block2.reg3.Y);
            $display("\tR20 = %d",path.registerFile.regWin1.block2.reg4.Y);
            $display("\tR21 = %d",path.registerFile.regWin1.block2.reg5.Y);
            $display("\tR22 = %d",path.registerFile.regWin1.block2.reg6.Y);
            $display("\tR23 = %d",path.registerFile.regWin1.block2.reg7.Y);
            $display("\tR24 = %d",path.registerFile.regWin1.block3.reg0.Y);
            $display("\tR25 = %d",path.registerFile.regWin1.block3.reg1.Y);
            $display("\tR26 = %d",path.registerFile.regWin1.block3.reg2.Y);
            $display("\tR27 = %d",path.registerFile.regWin1.block3.reg3.Y);
            $display("\tR28 = %d",path.registerFile.regWin1.block3.reg4.Y);
            $display("\tR29 = %d",path.registerFile.regWin1.block3.reg5.Y);
            $display("\tR30 = %d",path.registerFile.regWin1.block3.reg6.Y);
            $display("\tR31 = %d",path.registerFile.regWin1.block3.reg7.Y);
            

      
      
      
      
      
      
      
      
 end

endmodule