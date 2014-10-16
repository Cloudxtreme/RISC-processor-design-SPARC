/**************************************
* Module: DataPathV4
* Date:2014-10-11  
* Author: josediaz     
*
* Description: DataPath with IT - integrated tester
***************************************/
module  DataPathV4();

    integer i;
    reg [31:0] buffer[0:255];
    reg [31:0] IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, MDR_AUX, MAR_AUX, tQ_out;
    reg [0:0] MFC;
    reg [0:0] IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD,tQE,tQClr, 
    nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, PSRE, BAUX, 
    RFE, RA_SEL, DISP_SEL, AOP_SEL, WIME, ttAUX, ET, 
    PSR_SUPER, PSR_PREV_SUP, ClrPC, Clk;
    reg [1:0] nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, MAR_SEL, MDR_SEL;
    reg [4:0] CWP;
    reg [5:0] OP1;
    reg [19:0] TBA_IN;
    reg [7:0] tt_IN;
    reg [31:0] WIM_IN, tQ_IN;

    //-----------CREATING ALU --------------//
    wire [0:0] N, Z, V, C, Carry;
    wire [31:0] alu_out;
    //output reg [31:0] result, output reg N, Z, V, C, input [31:0] A_in, B_in, input [5:0] opcode, input carry);
    ALU_32bit alu(alu_out,N, Z, V, C, RF_Aout, ALU_MUX_out, AOP_MUX_out[5:0], Carry);
    
    //--------CREATING REGISTERS----------//
    
    //buiding IR 
    
    wire [31:0] IR_out;
    register_32bit_le_aclr IR_REG(IR_out,MDR_out,IRE,1,Clk);
    
    //buiding PSR  {{24{ram[address][7]}}, ram[address]};
    //reg [31:0] PSR_in = ; 
    wire [31:0] PSR_out;
    register_32bit_le_aclr PSR_REG(PSR_out,{{8{1'b0}},N, Z, V, C,{12{1'b0}},PSR_SUPER, PSR_PREV_SUP,ET,CWP},PSRE,1,Clk);
    
    //buiding MAR
    
    wire [31:0] MAR_out;
    register_32bit_le_aclr MAR_REG(MAR_out,MAR_MUX_out,MARE,1,Clk);
    
    //buiding MDR 
    wire [31:0] MDR_out;
    register_32bit_le_aclr MDR_REG(MDR_out,MDR_MUX_out,MDRE,1,Clk);
     
    //buiding nPC
    wire [31:0] nPC_out;
    register_32bit_le_aclr nPC_REG(nPC_out,nPC_MUX_Out,nPCE,1,Clk);
   
    //buiding PC
    wire [31:0] PC_out;
    register_32bit_le_aclr PC_REG(PC_out,nPC_out,PCE,ClrPC,Clk);
    
    //buiding TBR
    //reg [31:0] TBR_in = {{TBA_IN},{ttAux_out},{4{1'b0}} };
    wire [31:0] TBR_out;
    register_32bit_le_aclr TBR_REG(TBR_out,{ {TBA_IN},{ttAux_out},{4{1'b0}} },TBRE,1,Clk);
    
    //buiding WIM
    wire [31:0] WIM_out;
    register_32bit_le_aclr WIM_REG(WIM_out,WIM_IN,WIME,1,Clk);
    
    //building trap Queue
    wire [31:0] trapQ_out;
    register_32bit_le_aclr trapQueue(trapQ_out,tQ_IN,tQE,tQClr,Clk);
    
    
    //--------- Special Components* -----//
    
    // branch_Aux(output reg [31:0] out, input [31:0] in_pc, input [29:0] in_disp, input [0:0] BAUX, dispSel);
    //building BranchAux
    wire [31:0] branchAux_out;
    branch_Aux branchAux(branchAux_out,PC_out,IR_out[29:0],BAUX,DISPSEL);
    
    //building tt_Aux
    //tt_Aux(output reg[7:0] out, input wire[31:0] aluOut, input ttAux);
    wire [7:0] ttAux_out;
    tt_Aux ttAux(ttAux_out, alu_out, ttAUX);
    
    //building nPcADD
    //nPC_ADD(output reg [31:0] out, input [31:0] pc, input [0:0] Sel, nPC_ADD);
    wire [31:0] nPC_ADD_out;
    nPC_ADD nPC_ADD_comp(nPC_ADD_out, nPC_out, nPC_ADDSEL, nPC_ADD);
    
    //building TB_ADD
    //TB_ADD(output reg[31:0] out, input wire[31:0] x, input TB_ADD);
    wire [31:0] TB_ADD_out;
    TB_ADD TB_ADD_comp(TB_ADD_out,TBR_out,TB_ADD);
    
    //------------ RAM ---------------//
    //ram_256b(output reg [31:0] DataOut, output reg MFC, input MFA, input [5:0] opcode, input [7:0] address, input [31:0] DataIn);
    wire [31:0] ram_dataOut;
    wire [0:0] MFC_special;
    ram_256b ram1(ram_dataOut, MFC_special, MFA, MOP_MUX_out[5:0], MAR_out[7:0], MDR_out);
    
    //------------ Register file ---------//
    wire [31:0] RF_Aout, RF_Bout;
    //RegisterFile(output reg [31:0] Aout, Bout, input [31:0] Rin, input [1:0] CWP, input [4:0] RA, RB, RC, input RFE, Clk);
    RegisterFile registerFile(RF_Aout, RF_Bout, CIN_MUX_out, CWP[1:0], RA_MUX_out[4:0], IR_out[4:0], RC_MUX_out[4:0], RFE,Clk);
    
    
    //------------ Muxes -------------//
    
    //mux_4x1_32bit(output reg[31:0] Y,input wire[1:0] s, input wire[31:0] I3, I2, I1, I0);
    // buidling nPC_MUX
    wire [31:0] nPC_MUX_Out;
    mux_4x1_32bit nPC_MUX(nPC_MUX_Out, nPC_SEL, alu_out, branchAux_out, TB_ADD_out, nPC_ADD_out); 
    
    //mux_2x1_32bit(output reg[31:0] Y,input wire[0:0] s, input wire[31:0] I1, I0);
    //buidling MOP_MUX
    wire [31:0] MOP_MUX_out;
    mux_2x1_32bit MOP_MUX(MOP_MUX_out,MOP_SEL, {{26{1'b0}},OP1}, {{26{1'b0}},IR_out[24:19]});
    
    //buidling AOP_MUX
    wire [31:0] AOP_MUX_out;
    mux_2x1_32bit AOP_MUX(AOP_MUX_out,AOP_SEL, {{26{1'b0}},OP1}, {{26{1'b0}},IR_out[24:19]});
    
    //buidling ALU_MUX
    //mux_4x1_32bit(output reg[31:0] Y,input wire[1:0] s, input wire[31:0] I3, I2, I1, I0);
    wire [31:0] ALU_MUX_out;
    reg [31:0]asdc;
    mux_4x1_32bit ALU_MUX(ALU_MUX_out, ALU_SEL, {10'h000,IR_out[21:0]}, {25'h0000000,IR_out[6:0]}, {{19{1'b0}},IR_out[12:0]}, RF_Bout);
    
    //building MDR_MUX
    wire [31:0] MDR_MUX_out;
    mux_4x1_32bit MDR_MUX(MDR_MUX_out, MDR_SEL, 32'd0, MDR_AUX,RF_Aout, ram_dataOut);
    
    //building MAR_MUX
    wire [31:0] MAR_MUX_out;
    mux_4x1_32bit MAR_MUX(MAR_MUX_out, MAR_SEL, 32'd0, MAR_AUX, PC_out, alu_out);
    
    //buiding RA_MUX
    wire [31:0] RA_MUX_out;    
    mux_2x1_32bit RA_MUX(RA_MUX_out, RA_SEL, {{27{1'b0}},IR_out[29:25]}, {{27{1'b0}},IR_out[18:14]} );
    
    //building RCMUX
    wire [31:0] RC_MUX_out;
    mux_4x1_32bit RC_MUX(RC_MUX_out, RC_SEL, 15, 17, 18, {{27{1'b0}},IR_out[29:25]});
    
    //buidling CINMUX
    wire [31:0] CIN_MUX_out;
    mux_4x1_32bit CIN_MUX(CIN_MUX_out, CIN_SEL, MDR_out, alu_out, nPC_out, PC_out);
    
    
    
    //-------//
    always @ (*) 
       begin
        MFC = MFC_special;
        IR = IR_out;
        PSR = PSR_out;
        MAR = MAR_out;
        MDR = MDR_out;
        PC = PC_out;
        nPC = nPC_out;
        TBR = TBR_out;
        WIM = WIM_out;
        asdc = ALU_MUX_out;
       end

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
        $readmemh("file2.dat",buffer);
        $display("  Preloading memory from file");
        OP1 = 6'h04;
        MOP_SEL  = 1;
        MDR_SEL = 2;
        MAR_SEL = 2;
        #500
        
        MDRE = 1;
        Clk = 0;
        MFA = 0;
        MDR_AUX = buffer[i[31:0]];
        MAR_AUX = i;
        #500
        MDRE = 0;
        #500
        Clk = 1;
        #500
        Clk = 0;
        #100
        MDRE = 1;
        #100
        MFA = 1;
        #500
        MFA = 0;
        
       
        //==================
        // crap test from here on
        $display("\ndataPath test");
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
    
    #100
    ClrPC = 1;
    $display("PC = %h",PC);
    
    $display("\nLoading PC to MAR");
    MAR_SEL <= 1;
    #500
    MARE = 0;
    #500
    Clk = 1;
    #100
    Clk = 0;
    MAR_SEL = 1;
    #100
    $display("MAR = %h",MAR_out);
    
    $display("\nLoading instruction from memory");
    MOP_SEL  =1;
    #500
    MDR_SEL = 0;
    #500
    OP1 = 6'h08;
    #1000 
    
    MFA = 1;
    #500
    $display("MFC = %d Memory Done!",MFC);

    $display("\nRAM_out to MDR and IR");
    MFA = 0;
    MDR_SEL <= 0;
    MDRE <= 0;
    IRE = 0;
    Clk = 1;
    #100
    Clk = 0;
    IRE = 1;
    MDRE = 1;
    $display("MDR = 0x%h",MDR); 
   
    $display("IR = 0x%h",IR);
    
    
    $display("\nSetting CWP = 0");
    
    CWP = 0;
    PSRE = 0;
    Clk = 1;
    #100
    Clk = 0;
    PSRE = 1;
    #100
    $display("CWP= %b",CWP[1:0]);
    
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
    
    $display("RA = r%d",RF_Aout);
    #100
    $display("RB = r%d",RF_Bout);
  
  #100
    $display("\nr17 = r17+r18");
    
    RC_SEL = 0;
    #500
    CIN_SEL = 2;
    #500
    RA_SEL = 0;
    #500
    AOP_SEL <= 0;
    #500
    ALU_SEL <= 0;
    #500
    $display("ALU_out = %h",alu_out);
    PSRE = 0;
    Clk = 1;
    #100
    Clk = 0;
    PSRE = 1;
    #100
    
        $display("N=%b Z=%b C=%b V=%b\n", N, Z, C, V);
    $display("Cin=%h",CIN_MUX_out);
    $display("R%d",RC_MUX_out[4:0]);
    
    
    //====!!!!use this type of instructions to write into the register file
    $display("\nStoring result in r17");
    RC_SEL = 2'b00;
    #500
    $display("R%d",RC_MUX_out[4:0]);
    CIN_SEL = 2;
    #500
    $display("Cin=%h",CIN_MUX_out);
    #100
    RFE = 0;
    #500
    Clk = 1;
    #500
    Clk = 0;
    #100
    RFE = 1;
    #100
  RA_SEL = 0;
    #1000
    $display("RA = r%h",RF_Aout);
    $display("RB = r%h",RF_Bout);
    
    //======!!!!!!!!!!!=========================
    
    $display("\nStoring result on memory");
    MDR_SEL = 1;
    #500
    MDRE= 0;
    #100
    Clk = 1;
    #200
    Clk = 0;
    MDRE = 1;
    #100
    
    $display("MDR = 0x%h",MDR_out);
    MOP_SEL  =1;
    OP1 = 6'h04;
    #1000 
    
    MFA = 1;
    #500
    $display("MFC = %d Memory Done!",MFC);
    
    $display("\nGetting result from memory");
    MOP_SEL  =1;
    OP1 = 6'h08;
    #1000 
    
    MFA = 1;
    #500
    $display("MFC = %d Memory Done!",MFC);
    $display("RAM_out to MDR");
    MFA = 0;
    MDR_SEL <= 0;
    MDRE <= 0;
    IRE = 0;
    Clk = 1;
    #100
    Clk = 0;
    IRE = 1;
    MDRE = 1;
    $display("MDR = 0x%h",MDR);
    
    
    
    
        
        
        
        // crap test up to here
        
        
     end 

endmodule

