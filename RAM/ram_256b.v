/**************************************
* Module: ram_256b
* Date:2014-09-27  
* Author: dmoran     
*
* Description: RAM module for SPARC implemetation.
***************************************/
module  ram_256b(output reg [31:0] DataOut, output reg MFC, input MFA, input [5:0] opcode, input [7:0] address, input [31:0] DataIn);
    reg [7:0] ram[0:255]; //256 localizaciones de 8 bits
    always @ (MFA, opcode)
    begin
        if(MFA)
            begin
                case(opcode)
                    6'b001001:  //ldsb load signed byte
                        begin
                            DataOut[7:0] = {{24{ram[address][7]}}, ram[address]};
                        end
                    6'b001010:  //ldsh load signed half word
                        begin
                            DataOut <= {{16{ram[address][7]}}, ram[address], ram[address+1] };
                        end
                    6'b001000:  //ld load word (32 bit)
                        begin
                            DataOut[7:0] <= ram[address + 3];
                            DataOut[15:8] <= ram[address + 2];
                            DataOut[23:16] <= ram[address + 1];
                            DataOut[31:24] <= ram[address];
                        end
                    6'b000001:  //ldub load unsigned byte
                        begin
                            DataOut[7:0] = {{24{1'b0}}, ram[address]};
                        end
                    6'b000010:  //lduh load unsinged half word
                        begin
                            DataOut <= {{16{1'b0}}, ram[address], ram[address+1] };
                        end
                    6'b000011:  //ldd load double word
                        begin
                            //
                        end
                    6'b000101:  //stb store byte
                        begin
                            ram[address] <= DataIn[7:0];
                        end
                    6'b000110:  //sth store half word
                        begin
                            ram[address] <= DataIn[15:8];
                            ram[address+1] <= DataIn[7:0];
                        end
                        6'b000100:  //st word
                        begin
                            ram[address] <= DataIn[31:24];
                            ram[address+1] <= DataIn[23:16];
                            ram[address+2] <= DataIn[15:8];
                            ram[address+3] <= DataIn[7:0];
                        end
                        6'b000111:  //st double word
                        begin
                            //
                        end
                    endcase
                    MFC = 1'b1; //set MFC to acknowledge operation complete
                end //end if MFA
         else 
            begin
                DataOut = 32'bz;   // else high impedance out 
                MFC = 0;           // clear MFC flag on MFA clear
            end
    end // end always

endmodule
