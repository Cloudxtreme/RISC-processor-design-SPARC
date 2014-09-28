/**************************************
* Module: GlobalBlock
* Date:2014-09-28  
* Author: josediaz     
*
* Description: Global Block module
***************************************/
module  GlobalBlock (output reg [31:0] Aout, Bout, input [31:0] in, input BE,RE7,RE6,RE5,RE4,RE3,RE2,RE1,RE0, input [2:0] RA, RB, input Clk);
 
 wire gate7;
 wire gate6;
 wire gate5;
 wire gate4;
 wire gate3;
 wire gate2;
 wire gate1;
 wire gate0;
 
 wire [31:0] reg7Out;
 wire [31:0] reg6Out;
 wire [31:0] reg5Out;
 wire [31:0] reg4Out;
 wire [31:0] reg3Out;
 wire [31:0] reg2Out; 
 wire [31:0] reg1Out;
 wire [31:0] reg0Out;
 
 wire [31:0] muxA1Out;
 wire [31:0] muxB1Out;
 wire [31:0] muxA0Out;
 wire [31:0] muxB0Out;

    wire [31:0] A_out;
    wire [31:0] B_out; 
 //----------------enable gate7---------------------------------\\
     
     nand(gate7, BE,RE7);
    
     register_32bit_le_aclr reg7(reg7Out,in,gate7,1,Clk);
 //------------------------------------------------------------\\
 
 //----------------enable gate6---------------------------------\\
     
     nand(gate6, BE,RE6);
      
     register_32bit_le_aclr reg6(reg6Out,in,gate6,1,Clk);
 //------------------------------------------------------------\\
 
 //----------------enable gate5---------------------------------\\
     
     nand(gate5, BE,RE5);
     
     register_32bit_le_aclr reg5(reg5Out,in,gate5,1,Clk);
 //------------------------------------------------------------\\
 
 //----------------enable gate4---------------------------------\\
     
     nand(gate6, BE,RE4);
     
     register_32bit_le_aclr reg4(reg4Out,in,gate4,1,Clk);
 //------------------------------------------------------------\\
 
 //----------------enable gate3---------------------------------\\
     
     nand(gate3, BE,RE3);
      
     register_32bit_le_aclr reg3(reg3Out,in,gate3,1,Clk);
 //------------------------------------------------------------\\
 
 //----------------enable gate2---------------------------------\\
     
     nand(gate2, BE,RE2);
     
     register_32bit_le_aclr reg2(reg2Out,in,gate2,1,Clk);
 //------------------------------------------------------------\\
 
 //----------------enable gate1---------------------------------\\
     
     nand(gate1, BE,RE1);
    
     register_32bit_le_aclr reg1(reg1Out,in,gate1,1,Clk);
 //------------------------------------------------------------\\
 
 //----------------enable gate0---------------------------------\\
     
     nand(gate0, BE,RE0);
     
     register_32bit_le_aclr reg0(reg0Out,in,gate0,0,Clk);
 //------------------------------------------------------------\\
     
     //Connecting Mux
     
     mux_4x1_32bit mux_4x1_A1(muxA1Out,RA[1:0],reg7Out,reg6Out,reg5Out,reg4Out);
     
     mux_4x1_32bit mux_4x1_B1(muxB1Out,RB[1:0],reg7Out,reg6Out,reg5Out,reg4Out);
     
     mux_4x1_32bit mux_4x1_A0(muxA0Out,RA[1:0],reg3Out,reg2Out,reg1Out,reg0Out);
     
     mux_4x1_32bit mux_4x1_B0(muxB0Out,RB[1:0],reg3Out,reg2Out,reg1Out,reg0Out);
    
     //Last Mux level 
     mux_2x1_32bit mux_2x1_A(A_out[31:0], RA[2], muxA1Out, muxA0Out);
     mux_2x1_32bit mux_2x1_B(B_out[31:0], RB[2], muxB1Out, muxB0Out);   
     
     always @ (*)
      begin 
         Aout = A_out;
         Bout = B_out;
      end
endmodule
