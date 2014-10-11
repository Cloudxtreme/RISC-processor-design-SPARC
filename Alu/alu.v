/**************************************
* Module: ALU_32bit
* Date:2014-09-24  
* Author: dmoran & josediaz    
*
* Description: 32 bit ALU for sparc implementation.
***************************************/
module  ALU_32bit(output reg [31:0] result, output reg N, Z, V, C, input [31:0] A_in, B_in, input [5:0] opcode, input carry);
    reg [32:0] temp_res;//reg N, Z, C, V
    reg [32:0] sub_temp;
    
    always @ (A_in, B_in, opcode, carry)
        begin
            case(opcode)
                6'b000000:  //add w.o. S
                    begin
                        result = A_in + B_in;
                    end
                6'b010000:  //add with S
                    begin
                        temp_res = A_in + B_in;
                        result = temp_res[31:0];
                        checkCarryFlag;   
                        checkAddOverflow;
                        checkNegFlag;
                        checkZeroFlag;
                    end
                6'b001000:  //add with carry w.o. S
                    begin
                        result = A_in + B_in + C;
                    end
                6'b011000:  //add with carry with S 
                    begin
                         
                        temp_res = A_in + B_in + C; //Sure?
                        result = temp_res[31:0];
                        checkAddOverflow;
                        checkNegFlag;
                        checkZeroFlag;
                        checkCarryFlag;
                    end
                6'b000100:  //sub w.o. carry w.o. S 
                    begin
                        result = A_in - B_in; 
                    end
                6'b010100:  //sub without carry with S 
                    begin
                        sub_temp = A_in - B_in;
                        result = sub_temp; 
                        checkSubOverflow;
                        checkNegFlag;
                        checkZeroFlag;
                        checkBorrow_CarryFlag;
                    end
                6'b001100:  //subx with carry w.o. S 
                    begin
                        result = A_in - B_in - ~C;
                    end
                6'b011100:  //subx with carry with S 
                    begin
                        sub_temp = A_in - B_in - ~C; //VERIFY
                        result = sub_temp;
                        checkSubOverflow;
                        checkNegFlag;
                        checkZeroFlag;
                        checkBorrow_CarryFlag;
                    end
                6'b000001:  // A AND B (bitwise) 
                    begin
                        result = A_in & B_in;               
                    end
                6'b010001:  // A AND B (bitwise) with S  
                    begin
                        result = A_in & B_in;
                        checkZeroFlag;
                        checkNegFlag;               
                    end                    
                6'b000101:  // A NAND B (bitwise) w.o S 
                    begin
                        result = ~(A_in & B_in);
                        
                    end
                6'b010101:  // A NAND B (bitwise) with S 
                    begin
                        result = ~(A_in & B_in);
                        checkZeroFlag;
                        checkNegFlag;
                    end
                6'b000010:  // A OR B  (bitwise) w.o S 
                    begin
                        result = A_in | B_in;
                    end
                6'b010010:  // A OR B  (bitwise) with S 
                    begin
                        result = A_in | B_in;
                        checkZeroFlag;
                        checkNegFlag;
                    end
                6'b000110:  // A NOR B (bitwise) with S
                    begin
                        result = ~(A_in | B_in);
                    end
                6'b010110:  // A NOR B (bitwise) with S
                    begin
                        result = ~(A_in | B_in);
                        checkZeroFlag;
                        checkNegFlag;
                    end
                6'b000011:  // A XOR B (bitwise) w.o. S
                    begin
                        result = A_in ^ B_in;
                    end
                6'b010011:  // A XOR B (bitwise) with S
                    begin
                        result = A_in ^ B_in;
                        checkZeroFlag;
                        checkNegFlag;
                    end
                6'b000111:  // A XNOR B (bitwise) w.o. S 
                    begin
                        result = ~(A_in ^ B_in);
                    end
                6'b010111:  // A XNOR B (bitwise) with S
                    begin
                        result = ~(A_in ^ B_in);
                        checkZeroFlag;
                        checkNegFlag;
                    end
                6'b100101:  //Shift left logical  
                    begin
                        result = A_in << B_in[31:0];
                    end
                6'b100110:  //Shift right logical
                    begin
                        result = A_in >> B_in[31:0];
                    end
                6'b100111:  //Shift right arithmetic
                    begin
                        result = A_in >>> B_in[31:0];
                    end
                endcase
             
        end //end always
      
    //Auxiliary functions for checking/setting status register flags
         
    task checkAddOverflow;
        begin
            //Check for the 2 result cases of a overflow: positive+positive=negative or negative+negative=positive
            if((A_in[31] == 0 && B_in[31] == 0 && result[31] == 1) || (A_in[31] == 1 && B_in[31] == 1 && result[31] == 0))
                V=1;
            else 
                V = 0;//no overflow
        end
    endtask
        
    task checkSubOverflow;
        begin
            //Check for the 2 result cases of a overflow: positive-negative=negative or negative-positive=positive
            if((A_in[31] == 0 && B_in[31] == 1 && result[31] == 1) || (A_in[31] == 1 && B_in[31] == 0 && result[31] == 0))
                V=1;
            else 
                V = 0;//no overflow
        end
    endtask
    
    task checkZeroFlag;
        begin 
            if(result == 0) Z = 1;
            else Z = 0;
        end
     endtask
     
     task checkNegFlag;
        begin 
            N = result[31];
        end
     endtask
     
     task checkCarryFlag;
        begin   //adding e.g. 1000 + 1000 =  10000                     substracting e.g. 1000 - 0101 = 
           if( temp_res[32] == 1 )
            begin
            C = 1;
            temp_res = 0;
            end 
           else C = 0;
        end
     endtask
     
     task checkBorrow_CarryFlag;
        begin
            C = ~sub_temp[32];
        end
     endtask
     
     task clearFlags;
      begin
        C = 0;
        V = 0;
        Z = 0;
        N = 0;
      end
     endtask
     
endmodule

