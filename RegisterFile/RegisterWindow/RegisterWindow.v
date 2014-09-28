/**************************************
* Module: RegisterWindow
* Date:2014-09-27  
* Author: josediaz     
*
* Description: Register window module
***************************************/
module  RegisterWindow(output reg [31:0] AxOut, BxOut, Aout, Bout, input [31:0] AxIn, BxIn, in, input WEx, input [4:0] RA, RB, input WE, BE3, BE2, BE1, input [7:0] RE, input [31:0] GA, GB, input Clk, RFE); 
  
  //Build two level combinatiorial circuit BLOCK 3
  wire block3AndLevel1;
  and(block3AndLevel1, BE3, WE, RFE);
  
  wire block3And2Level1;
  and(block3And2Level1, BE1, WEx, RFE);
  
  wire block3EN;
  or(block3EN,block3AndLevel1,block3AndLevel2);
    
  //Build Block3
  wire [31:0] Aout_temp_block3;
  wire [31:0] Bout_temp_block3; 
  register_block_32bit block3(Aout_temp_block3, Bout_temp_block3, in, block3EN, RE[7], RE[6], RE[5], RE[4], RE[3], RE[2], RE[1], RE[0], RA[2:0], RB[2:0], Clk);
  //-------------------------------\\
  
  //Build 1 level combinatiorial circuit BLOCK 2
  wire block2EN;
  and(block2EN, BE2, WE, RFE);
  
  //Build Block2
  wire [31:0] Aout_temp_block2;
  wire [31:0] Bout_temp_block2; 
  register_block_32bit block2(Aout_temp_block2, Bout_temp_block2, in, block2EN, RE[7], RE[6], RE[5], RE[4], RE[3], RE[2], RE[1], RE[0], RA[2:0], RB[2:0], Clk);
  
  //-------------------------------\\
  
  //build mux levels
  
  wire [31:0] AOutFinal;
  wire [31:0] BOutFinal;
  
  mux_4x1_32bit muxA(AOutFinal, RA[4:3], Aout_temp_block3, Aout_temp_block2, AxIn,GA);
  mux_4x1_32bit muxB(BOutFinal, RB[4:3], Bout_temp_block3, Bout_temp_block2, BxIn,GB);
  
  always @ (*) 
   begin
    AxOut = Aout_temp_block3;
    BxOut = Bout_temp_block3;
    Aout = AOutFinal;
    Bout = BOutFinal;
   end
  
endmodule

