/**************************************
* Module: DataPathV2
* Date:2014-10-11  
* Author: josediaz     
*
* Description: DataPath with IT - integrated tester
***************************************/
module  DataPathV2(output reg [31:0] IR, PSR, MAR, MDR, PC, nPC, TBR, WIM, output reg [0:0] MFC, input [0:0] IRE, MDRE, TBRE, nPCE, PCE, MARE, nPC_ADD, nPC_ADDSEL, TB_ADD, MFA, MOP_SEL, MAR_SEL, PSRE, BAUX, RFE, RA_SEL, MDR_SEL, DISPSEL, AOP_SEL, WIME, ttAUX, ET, PSR_SUPER, PSR_PREV_SUP, ClrPC, Clk, input [1:0] nPC_SEL, ALU_SEL, CIN_SEL, RC_SEL, input [4:0] CWP, input [5:0] OP1, input [19:0] TBA_IN, input [31:0] WIM_IN);

    //-----------CREATING ALU --------------//
    wire [0:0] N, Z, V, C, Carry;
    wire [31:0] alu_out;
    //output reg [31:0] result, output reg N, Z, V, C, input [31:0] A_in, B_in, input [5:0] opcode, input carry);
    ALU_32bit alu(alu_out,N, Z, V, C, RF_Aout, ALU_MUX_out, AOP_MUX_out[5:0], Carry);
    
    //--------CREATING REGISTERS----------//
    
    //buiding IR 
    reg [31:0] IR_in;
    wire [31:0] IR_out;
    register_32bit_le_aclr IR_REG(IR_out,IR_in,IRE,1,Clk);
    
    //buiding PSR  {{24{ram[address][7]}}, ram[address]};
    //reg [31:0] PSR_in = ; 
    wire [31:0] PSR_out;
    register_32bit_le_aclr PSR_REG(PSR_out,{{8{1'b0}},N, Z, V, C,{12{1'b0}},PSR_SUPER, PSR_PREV_SUP,ET,CWP},PSRE,1,Clk);
    
    //buiding MAR
    reg [31:0] MAR_in;
    wire [31:0] MAR_out;
    register_32bit_le_aclr MAR_REG(MAR_out,MAR_in,MARE,1,Clk);
    
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
    ram_256b ram(ram_dataOut, MFC_special, MFA, MOP_MUX_out[5:0], MAR_out[7:0], MDR_out);
    
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
    mux_4x1_32bit ALU_MUX(ALU_MUX_out, ALU_SEL, {10'h000,IR_out[21:0]}, {25'h0000000,IR_out[6:0]}, {{19{1'b0}},IR_out[12:0]}, RF_Bout);
    
    //building MDR_MUX
    wire [31:0] MDR_MUX_out;
    mux_2x1_32bit MDR_MUX(MDR_MUX_out, MDR_SEL, RF_Aout, ram_dataOut);
    
    //building MAR_MUX
    wire [31:0] MAR_MUX_out;
    mux_2x1_32bit MAR_MUX(MDR_MUX_out, MAR_SEL, PC_out, alu_out);
    
    //buiding RA_MUX
    wire [31:0] RA_MUX_out;    
    mux_2x1_32bit RA_MUX(RA_MUX_out, RA_SEL, {27'h0000000,IR_out[29:25]}, {27'h0000000,IR_out[18:14]} );
    
    //building RCMUX
    wire [31:0] RC_MUX_out;
    mux_4x1_32bit RC_MUX(RC_MUX_out, RC_SEL, 15, 17, 18, {27'h0000000,IR_out[29:25]});
    
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
       end

   initial begin               //simulation time
        ram.ram[0] <= 8'h9C;
        ram.ram[1] <= 8'h04;
        ram.ram[2] <= 8'h40;
        ram.ram[3] <= 8'h12;
        
        
        
     end 

endmodule
