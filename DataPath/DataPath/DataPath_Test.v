/**************************************
* Module: DataPath_Test
* Date:2014-10-11  
* Author: josediaz     
*
* Description: Testing the Processors Data Path
***************************************/
module  DataPath_Test();
    // This test provides for
    //
    // 
    wire [31:0] IR, PSR, MAR, MDR, PC, nPC, TBR, WIM;
    wire [0:0] MFC;
    
    reg [0:0] IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD, nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, MAR_SEL, PSRE, BAUX, RFE, RA_SEL, MDR_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, PSR_SUPER, PSR_PREV_SUP, ClrPC, Clk;
    reg [1:0] nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL;
    reg [4:0] CWP;
    reg [5:0] OP1;
    reg [19:0] TBA_IN;
    reg [31:0] WIM_IN;
    
    parameter sim_time = 10000000; 
    
    DataPath path(IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, MFC, 
     IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD, nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, MAR_SEL, PSRE, BAUX, RFE, RA_SEL, MDR_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, PSR_SUPER, PSR_PREV_SUP, ClrPC, Clk,
     nPC_SEL, ALU_SEL, CIN_SEL,RC_SEL,
      CWP, OP1, TBA_IN,WIM_IN);    
    //DataPath(output reg [31:0] IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, output reg [0:0] MFC,
    //input [0:0] IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD, nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, MAR_SEL, PSRE, BAUX, RFE, RA_SEL, MDR_SEL, DISPSEL, AOP_SEL, WIME, ttAUX, ET, PSR_SUPER, PSR_PREV_SUP, ClrPC, Clk, input [1:0]
    //input nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL,
    // input [4:0] CWP,
    // input [5:0] OP1, 
    //input [19:0] TBA_IN, input [31:0] WIM_IN); 
     
     initial begin
    $display("dataPath test");
    $display("Initializing data path");
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 1;
    MARE <= 0;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1;
    RA_SEL <= 1;
    MDR_SEL <= 1;
    ALU_SEL <= 1;
    CIN_SEL <= 1;
    RC_SEL <= 1; 
    DISP_SEL <= 1;
    AOP_SEL <= 1;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0;
    
    #700
    
    $display("Toggling: ClrPC");
    ClrPC <= 0;

    
    #700
    
    $display("PC: %h", PC); 
    $display("Setting memory opcode: load <= 001000");
    OP1 <= 6'b001000; //load
    #700
 
    $display("Setting register's enable signals");
    IRE <= 0;
    MDRE <= 0; 
    
    ClrPC <= 0;
    MARE <= 0;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1;
    RA_SEL <= 1;
    MDR_SEL <= 0;
    ALU_SEL <= 1;
    CIN_SEL <= 1;
    RC_SEL <= 1; 
    DISP_SEL <= 1;
    AOP_SEL <= 1;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0;
    
    #700
    $display("MARE: %h", MARE);
    $display("Setting MFA");
  
    MFA <= 1; 
    
    #1000
    $display("Before toggling MFC - MFC: %h", MFC);
    Clk <= 1;
    
    #1000
    $display("Clock <= 0");
    $display("MDR: %h ; IR: %h ; MFC: %h", MDR, IR, MFC);
    Clk <= 0;
      
    #1000
    $display("MDR: %h ; IR: %h ; MFC: %h", MDR, IR, MFC);
    $display("MFA <= 0");
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1;
    RA_SEL <= 1;
    MDR_SEL <= 0;
    ALU_SEL <= 1;
    CIN_SEL <= 1;
    RC_SEL <= 1; 
    DISP_SEL <= 1;
    AOP_SEL <= 1;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0;
   
   #1000
   $display("MDR: %h ; IR: %h ; MFC: %h", MDR, IR, MFC);
   $display("Setting RC_SEL <= 2");
   IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1;
    RA_SEL <= 1;
    MDR_SEL <= 0;
    ALU_SEL <= 1;
    CIN_SEL <= 1;
    RC_SEL <= 2; 
    DISP_SEL <= 1;
    AOP_SEL <= 1;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0;  
    
    #700
    $display(" RFE <= 0");
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 0;
    RA_SEL <= 1;
    MDR_SEL <= 0;
    ALU_SEL <= 1;
    CIN_SEL <= 1;
    RC_SEL <= 2; 
    DISP_SEL <= 1;
    AOP_SEL <= 1;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0;   
    
    #700
    $display("Clock <= 1");  
    Clk <= 1;   
    
    #700
    
    $display("Clock <= 0");
    $display("MDR: %h ; IR: %h ; MFC: %h", MDR, IR, MFC); 
    Clk <= 0; //baje
    
    #500
    
    $display("RC_SEL <= 1, RFE <= 0");
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 0; // 0
    RA_SEL <= 1;
    MDR_SEL <= 0;
    ALU_SEL <= 1;
    CIN_SEL <= 1; 
    RC_SEL <= 1;  //cambie!!! 
    DISP_SEL <= 1;
    AOP_SEL <= 1;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0;     
    
    #500
    
    $display("Clock <= 1");
    Clk <= 1;   //subi!
    
    #500
    
    $display("RFE <= 1");
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1; 
    RA_SEL <= 1;
    MDR_SEL <= 0;
    ALU_SEL <= 1;
    CIN_SEL <= 1; 
    RC_SEL <= 1;  
    DISP_SEL <= 1;
    AOP_SEL <= 1;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 1;   
    
    #700
    $display("clock <= 0");
    Clk <= 0;   //baje!
    #700
    $display("RC_SEL <= 0; CIN_SEL <= 2; RA_SEL <= 0");
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1; 
    RA_SEL <= 0;
    MDR_SEL <= 0;
    ALU_SEL <= 1;
    CIN_SEL <= 2; 
    RC_SEL <= 0;  
    DISP_SEL <= 1;
    AOP_SEL <= 1;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0;   
    
    #500
    $display("AOP_SEL <= 0; RFE <= 0; ALU_SEL <= 0");
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 0; 
    RA_SEL <= 0;
    MDR_SEL <= 0;
    ALU_SEL <= 0;
    CIN_SEL <= 2; 
    RC_SEL <= 0;  
    DISP_SEL <= 1;
    AOP_SEL <= 0;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0; 
    
    #500
    $display("Clock <= 1");
    Clk <= 1; 
    
    #700
    
    $display("Clock <= 0; RFE <= 1");
    Clk <= 0; 
     
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1; 
    RA_SEL <= 0;
    MDR_SEL <= 0;
    ALU_SEL <= 0;
    CIN_SEL <= 2; 
    RC_SEL <= 0;  
    DISP_SEL <= 1;
    AOP_SEL <= 0;
    WIME <= 1;
    ttAUX <= 1; 
    
    #500
    $display("RA_SEL <= 1; MDR_SEL <= 1; MDRE <= 0; IRE <= 0");
    IRE <= 0;
    MDRE <= 0; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1; 
    RA_SEL <= 1;
    MDR_SEL <= 1;
    ALU_SEL <= 0;
    CIN_SEL <= 2; 
    RC_SEL <= 0;  
    DISP_SEL <= 1;
    AOP_SEL <= 0;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0; 
    
    #500
    
    $display("Clock <= 1");
    Clk <= 1;
    
    #700
    $display("Clock <= 0; IRE <= 1;  MDRE <= 1; ");
    IRE <= 1;
    MDRE <= 1; 
    TBRE <= 1;
    nPCE <= 1;
    PCE <= 1;
    ClrPC <= 0;
    MARE <= 1;
    nPC_ADD <= 1;
    nPC_ADDSEL <= 1;
    TB_ADD <= 1; 
    MFA <= 0; 
    MOP_SEL <= 1; 
    MAR_SEL <= 1;
    nPC_SEL <= 1;
    PSRE <= 1;
    BAUX <= 1;
    RFE <= 1; 
    RA_SEL <= 1;
    MDR_SEL <= 1;
    ALU_SEL <= 0;
    CIN_SEL <= 2; 
    RC_SEL <= 0;  
    DISP_SEL <= 1;
    AOP_SEL <= 0;
    WIME <= 1;
    ttAUX <= 1; 
    Clk <= 0;
    #700
    $display("IR: %h", IR);
    
    
    
    
    
    
      
    
     
end
      
    /*
    MDRE <= ,
    nPC_ADD <=,
    nPC_ADDSEL <= ,
    ClrPC <= ,
    TB_ADD <= , 
    MFA <= , 
    MOP_SEL <= , 
    MAR_SEL <= ,
    nPC_SEL <= ,
    PSRE <= ,
    BAUX <= ,
    RFE <= ,
    RA_SEL <= ,
    MDR_SEL <= ,
    ALU_SEL <= ,
    CIN_SEL <= 
    RC_SEL <= , 
    DISP_SEL <= ,
    AOP_SEL <= ,
    WIME <= ,
    ttAUX <= ;
   */

   

endmodule

