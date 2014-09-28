/**************************************
* Module: RegisterFile
* Date:2014-09-28  
* Author: josediaz     
*
* Description: Register File module
***************************************/
module  RegisterFile(output reg [31:0] Aout, Bout, input [31:0] Rin, input [1:0] CWP, input [4:0] RA, RB, RC, input RFE, Clk);

    //Building
    wire [0:0] RFE_signal;
    not(RFE_signal, RFE);
    
    //Building Register Enable 3 x 8 Decoder level
    wire [7:0] RE_Bus;
    decoder_3x8 decRE (RE_Bus, RC[2:0]);
    
    //Building Block Enable 2 x 4 Decoder level
    wire [3:0] BE_Bus;
    decoder_2x4 decBE (BE_Bus, RC[4:3]);
    
    //Building Window Enable 2 x 4 Decoder level
    wire [3:0] WE_Bus;
    decoder_2x4 decWE (WE_Bus, CWP[1:0]);
    
    //global block enable
    wire [0:0] globalBlockEN;
    and(globalBlockEN, RFE_signal,BE_Bus[0]); 
    
    //Building Global Block
    wire [31:0] globalOut_A, globalOut_B;
    GlobalBlock global (globalOut_A, globalOut_B, Rin, globalBlockEN, RE_Bus[7], RE_Bus[6], RE_Bus[5], RE_Bus[4], RE_Bus[3], RE_Bus[2], RE_Bus[1], RE_Bus[0], RA[2:0], RB[2:0], Clk);
    
    //Building Register Window #3 Outputs 
    wire [31:0] regWin3_AxOut, regWin3_BxOut, regWin3_AOut, regWin3_BOut;
    
    //Building Register Window #2 Outputs 
    wire [31:0] regWin2_AxOut, regWin2_BxOut, regWin2_AOut, regWin2_BOut;
    
    //Building Register Window #1 Outputs 
    wire [31:0] regWin1_AxOut, regWin1_BxOut, regWin1_AOut, regWin1_BOut;
    
    //Building Register Window #0 Outputs 
    wire [31:0] regWin0_AxOut, regWin0_BxOut, regWin0_AOut, regWin0_BOut;
    
    //---------------------------register windows-------------------------------\\
    
    //Building Register Window 3
    RegisterWindow regWin3(regWin3_AxOut, regWin3_BxOut, regWin3_AOut, regWin3_BOut, regWin2_AxOut, regWin2_BxOut, Rin, WE_Bus[0], RA, RB, WE_Bus[3], BE_Bus[3], BE_Bus[2], BE_Bus[1], RE_Bus, globalOut_A, globalOut_B, Clk, RFE_signal);
    
    //Building Register Window 2
    RegisterWindow regWin2(regWin2_AxOut, regWin2_BxOut, regWin2_AOut, regWin2_BOut, regWin1_AxOut, regWin1_BxOut, Rin, WE_Bus[3], RA, RB, WE_Bus[2], BE_Bus[3], BE_Bus[2], BE_Bus[1], RE_Bus, globalOut_A, globalOut_B, Clk, RFE_signal);
    
    //(output reg [31:0] AxOut, BxOut, Aout, Bout, input [31:0] AxIn, BxIn, in, input WEx, input [4:0] RA, RB, input WE, BE3, BE2, BE1, input [7:0] RE, input [31:0] GA, GB, input Clk);
    
    //Building Register Window 1
    RegisterWindow regWin1(regWin1_AxOut, regWin1_BxOut, regWin1_AOut, regWin1_BOut, regWin0_AxOut, regWin0_BxOut, Rin, WE_Bus[2], RA, RB, WE_Bus[1], BE_Bus[3], BE_Bus[2], BE_Bus[1], RE_Bus, globalOut_A, globalOut_B, Clk, RFE_signal);
    
    //Building Register Window 0
    RegisterWindow regWin0(regWin0_AxOut, regWin0_BxOut, regWin0_AOut, regWin0_BOut, regWin3_AxOut, regWin3_BxOut, Rin, WE_Bus[1], RA, RB, WE_Bus[0], BE_Bus[3], BE_Bus[2], BE_Bus[1], RE_Bus, globalOut_A, globalOut_B, Clk, RFE_signal);
    
    //------------------------------Mux level-----------------------------------------\\
    
    wire [31:0] Aout_final, Bout_final;
    mux_4x1_32bit mux1 (Aout_final, CWP, regWin3_AOut, regWin2_AOut, regWin1_AOut, regWin0_AOut);
    
    mux_4x1_32bit mux0 (Bout_final, CWP, regWin3_BOut, regWin2_BOut, regWin1_BOut, regWin0_BOut);
    
    always @ (*)
        begin
            Aout = Aout_final;
            Bout = Bout_final;
        end 
    
endmodule

