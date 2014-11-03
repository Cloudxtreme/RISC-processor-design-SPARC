/**************************************
* Module: dp5Tester
* Date:2014-10-11  
* Author: josediaz     
*
* Description: Testing module for data path version 5
***************************************/

module  dp5Tester();


 integer i;
    reg [31:0] buffer[0:63];
    wire [31:0] IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, TQ,ALU;
    wire [0:0] MFC;
    reg [0:0] IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD,tQE,tQClr, IRClr, 
    nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, PSRE, BAUX, 
    RFE, RA_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, ALUE,
    PSR_SUPER, PSR_PREV_SUP, ClrPC, Clk, nPCClr;
    reg [31:0] MDR_AUX, MAR_AUX;
    reg [1:0] nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, MAR_SEL, MDR_SEL, PSR_SEL, TBA_SEL;
    reg [4:0] CWP;
    reg [5:0] OP1;
    reg [24:0] TBA_IN;
    reg [5:0] tQ_IN;
    reg [31:0] WIM_IN;

DataPathV5 path(IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, TQ, ALU,
                     MFC, IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD,tQE,tQClr, IRClr, 
                    nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, PSRE, BAUX, 
                    RFE, RA_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, ALUE,
                    PSR_SUPER, PSR_PREV_SUP, ClrPC, Clk, nPCClr,MDR_AUX,MAR_AUX,
                    nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, MAR_SEL, MDR_SEL, PSR_SEL, TBA_SEL,
                    CWP,OP1, TBA_IN,
                     tQ_IN, WIM_IN);


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
        $readmemb("file3.dat",buffer);
        $display("  Preloading memory from file");
        for(i=0;i<128;i=i+1)begin
            path.ram1.ram[i] = buffer[i[7:0]];
        end
        OP1 = 6'h04;
        MOP_SEL  = 1;
        MDR_SEL = 2;
        MAR_SEL = 2;
       
        CWP = 1;
        MAR_AUX = 0;
           MDR_AUX = 15;    
        #100
        MDRE = 0;
        #100
        Clk = 1;
        #100
        Clk = 0;
        MDRE = 1;
        #100
        
        $display("\nStoring MDR in r17");
    RC_SEL = 2'b10;
    #500
    
    CIN_SEL = 3;
    #500
    
    #100
    RFE = 0;
    #500
    Clk = 1;
    #500
    Clk = 0;
    RFE = 1;
        
        
        #50
        MDR_AUX = 17;
        #100
        MDRE = 0;
        #100
        Clk = 1;
        #100
        Clk = 0;
        MDRE = 1;
        #50
         #100
    $display("Storing MDR in r18");
    RC_SEL = 2'b01;
    #500
  
    CIN_SEL = 3;
    #500
    
    #100
    RFE = 0;
    #500
    Clk = 1;
    #500
    Clk = 0;
    RFE = 1;
    #100
  RA_SEL = 0;
    #500
        
        
        
//       
//       Clk = 0;
//        #500
//        Clk = 1;
//        #500
//        MAR_SEL <= 2;
//        MAR_AUX <= i;
//        MDR_SEL <= 2;
//        MDR_AUX <= buffer[i[31:0]];
//        MOP_SEL <= 1;
//        OP1 <= 6'b000100;
//        
//        #500
//        Clk = 0;
//        #500
//        Clk = 1;
//        #500
//        MDRE = 0;
//        MARE = 0;
//        
//        #500
//        Clk = 0;
//        #500
//        Clk = 1;
//        #500
//        MDRE = 1;
//        MARE = 1;
//        
//        #500
//        Clk = 0;
//        #500
//        Clk = 1;
//        #500
//        
//        $display("\nMDR_OUT: %h", MDR);
//        $display("MAR_OUT: %h", MAR);
//        //$display("MOP: %b",MOP_MUX_out[5:0]);
//        
//        #500
//        Clk = 0;
//        #500
//        Clk = 1;
//        #500
//        MFA = 1;
//        
//        #500
//        Clk = 0;
//        #500
//        Clk = 1;
//        #500
//        MFA = 0;
        //$display("MDR_OUT: %h", MDR_out);
       
        //==================
        // crap test from here on
    $display("\n========DataPath test========");
    $display("Reset 1");
    #500
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
    
    #500
    $display("Reset 2");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    //clears en 0
    ClrPC <= 0;
    nPCClr <= 0;
    tQClr <= 0;
    IRClr <= 0;
    
    #500
    $display("Reset 3");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    // putting TBRE = 0
    //Clr <= 1   
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
    
    #500
    $display("Reset 4");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    TBRE <= 1;
    nPCE  <= 0;
    nPC_ADD <= 1;
    PSRE <= 1;
    RFE <= 1;
    WIME <= 1;
       
    #500
    $display("Reset 5");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    nPCE <= 1; 
    nPC_ADD <= 0;
    
    #500
    $display("RESET DONE");
    $display("\t>>> debug ::: PC: %h - nPC: %h\n", PC, nPC); 
    
    #500
    $display("FETCH 1");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    MARE = 0;
    MAR_AUX = 0;
    MAR_SEL = 2;
    
    #500
    $display("FETCH 2");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
  
    MARE = 1;
    MOP_SEL = 1;
    MDR_SEL = 0;
    OP1 = 6'h08;
    
    #500
//    $display("\t>>> debug ::: OP1: %b",OP1 );
//    $display("\t>>> debug ::: MAR: %h",MAR_out );
//    $display("\t>>> debug ::: MOP_MUX_OUT: %h", MOP_MUX_out);
//    $display("\t>>> debug ::: MDR_OUT: %h",MDR_out );
    
    $display("FETCH 3");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    MDRE = 0;
    MFA = 1;
    //MDRE = 1;
        
    
    //$display("\t>>> debug ::: MFC: %b",MFC);
    //$display("\t>>> debug ::: MDR_OUT: %h",MDR_out );
    
    $display("FETCH 4");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    IRE = 0;
    MFA = 0;
    MDRE = 1;
    
    #500
    //$display("\t>>> debug ::: RAM_OUT: %h",MDR_out );
    $display("FETCH 5");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    IRE <= 1;
    
    #500
    $display("FETCH DONE");
    $display("\t>>> debug ::: IR: %h\n", IR);
    
    
    $display("ALop 1");
    
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    CIN_SEL <= 2;
    RA_SEL <= 0;
    RC_SEL <= 0;
    AOP_SEL <= 0;
    ALU_SEL <= 0;
    #500
     $display("ALop 2");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
       
    
    RFE = 0;
    ALUE = 1;
    
    #500
    
     $display("ALop 3");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    RFE = 1;
    ALUE = 0;
    
    #500
    $display("ALop Done");
    //23-20
    $display("\t>>> debug ::: ALU_out: %h", ALU);
    $display("\t>>> debug ::: PSR[23:20]: %b\n", PSR[23:20]);
    
    
    $display("nPC_Update_1");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    PCE <= 0;
    
    #500
    $display("nPC_Update_2");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    PCE <= 1; nPC_ADDSEL <= 0; nPC_SEL <= 0;
    
    #500
    $display("nPC_Update_3");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    nPC_ADD = 1;
    nPCE = 0; 
    
    #500
    $display("nPC_Update_4");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    nPCE = 1; nPC_ADD = 0;
    
    #500
    $display("nPC_Update Done!");
    $display("\t>>> debug ::: PC: %h - nPC: %h\n", PC, nPC);
    
    #500
    Clk = 0;
    RFE = 1;
        
        MDR_SEL <= 2;
        #50
        MDR_AUX = 32'h3c800005;
        #100
        MDRE = 0;
        #100
        Clk = 1;
        #100
        Clk = 0;
        #100
        IRE = 0;
        #100
        Clk = 1;
        #100
        IRE = 1;
    
    #500
    $display("branch instruction wt. cond=false and a=1");
    $display("branch 1");
    #500
    Clk = 0;
    MDRE = 1;
    #500
    Clk = 1;
    #500
    
    PCE <=0;
    
    #500
    $display("branch 2");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    PCE <=1;
    
    #500
    $display("branch F1");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    nPC_ADDSEL <= 1; nPC_SEL <= 0;
    
    #500
    $display("branch F2");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    nPCE <= 0; nPC_ADD <= 1;
    
    #500
    $display("branch F3");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    nPCE <= 1; nPC_ADD <= 0;
    
    #500
    $display("branch false with a=1 done");
    $display("\t>>> debug ::: PC: %h - nPC: %h\n", PC, nPC);
    
     #500
    $display("branch instruction wt. cond=true and disp22=5");
    $display("branch 1");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    PCE <=0;
    
     #500
    $display("branch T1");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    PCE = 1;
    nPC_SEL <= 2; DISP_SEL <= 0;
    
     #500
    $display("branch T2");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    nPCE <= 0; BAUX <= 1;
    
    #500
    $display("branch T3");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    nPCE <= 1; BAUX <= 0;
    
     #500
    $display("branch true is done");
    $display("\t>>> debug ::: PC: %h - nPC: %h\n", PC, nPC);
    
    #500
    Clk = 0;
    RFE = 1;
        PSR_SEL <= 1;
        TBA_SEL <= 1;
        MDR_SEL <= 2;
        #50
        PSR_SUPER <= 0;
        PSR_PREV_SUP <= 1;
        ET <= 1;
        CWP <= 1;
        TBA_IN <= 25'h0000000;
        MDR_AUX = 32'h3c800005;
        tQ_IN = 6'b001000;
        #100
        TBRE = 0;
        MDRE = 0;
        PSRE = 0;
        tQE = 0;
        #100
        Clk = 1;
        #100
        Clk = 0;
        #100
        IRE = 0;
        #100
        Clk = 1;
        #100
        IRE = 1;
    
    #500
    $display("trap instruction wt. cond=true");
    $display("\t>>> debug ::: PSR[7:0]: %b\n", PSR[7:0]);
    $display("trap 1");
    #500
    Clk = 0;
    MDRE = 1;
    TBRE = 1;
    tQE = 1;
    TBA_SEL = 0;
    PSRE = 1;
    #500
    Clk = 1;
    #500
    
    // check cond
    tQ_IN = 6'b001000;
    
    #500
    $display("trap 2");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    tQE <=0;
    
     #500
    $display("trap 3");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    ttAUX = 1;
    tQE <=1;
    
    //$display("\t>>> debug ::: TBR: %b\n", TBR_out);
     #500
    $display("Trap Generated!");
    
     #500
     $display("\t>>> debug ::: trapQ: %b\n", TQ[5:0]);
    $display("trapQ 1");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
    PSR_SEL <= 1;
    PSRE <= 0;
    PSR_SUPER <= 1;
        PSR_PREV_SUP <= 0;
        ET <= 0;
        CWP <= 0;
        RFE <= 0;
        CIN_SEL <= 0;
        RC_SEL <= 2;
        //ttAUX =0;
        
        $display("trapQ 2");
       // $display("\t>>> debug ::: trapQ: %b\n", ttAux_out[2:0]);
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
        PSRE <= 1;
        PSR_SEL <= 0;
        RFE <= 1;
        
        
        
       #500 
       
            $display("trapQ 3");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500
    
        RFE <= 0;
        CIN_SEL <= 1;
        RC_SEL <= 1;
        
        nPC_SEL <= 1;
      #500  
      
            $display("trapQ 4");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500   
     nPCE = 0;
     RFE = 1;
     TBRE = 0;
     ttAUX = 1;
     TBA_SEL=0;
     
     #10
     
     
     #500
       $display("trapQ 5");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500   
    TBRE =0;
    nPCE = 1;
    ttAUX =0;
    
   //PCE = 0;
    
    #500
     $display("trapQ 6");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500   
    //$display("\t>>> debug ::: ttAux: %b\n", ttAux_out[2:0]);
    nPC_ADDSEL = 0;
    nPC_SEL = 1;
    //PCE = 1;
    
    #500
     $display("trapQ 7");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500   
    TBRE = 1;
    nPCE = 0;
    tQ_IN = 0;
    tQE = 0;
    
    //$display("\t>>> debug ::: TBR: %b\n", TBR_out);
   #500 
      $display("trapQ 8");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500   
    tQE = 1;
    nPCE = 1;
    PCE = 0;
    
    #500 
      $display("trapQ 9");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500 
    nPC_SEL = 0;
    PCE = 1;
    
      $display("trapQ 9");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500 
    nPC_ADD = 1;
    nPCE = 0;
    PCE = 1;
    
    
     $display("trapQ 10");
    #500
    Clk = 0;
    #500
    Clk = 1;
    #500 
    nPC_ADD = 0;
    nPCE = 1;
    
    
    $display("trap true is done");
    $display("\t>>> debug ::: trapQ: %b\n", TQ[5:0]);
    $display("\t>>> debug ::: PC: %h - nPC: %h\n", PC, nPC);
   
    $display("\t>>> debug ::: TBR: %h\n", TBR);
    $display("\t>>> debug ::: PSR[7:0]: %b\n", PSR[7:0]);
    

    
    
     end 





endmodule