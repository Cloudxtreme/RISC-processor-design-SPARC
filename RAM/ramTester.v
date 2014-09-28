/**************************************
* Module: ramTester
* Date:2014-09-27  
* Author: dmoran     
*
* Description: Testing Module for 256 RAM
***************************************/
module  ramTester;
    reg [31:0] buffer; 
        reg [31:0] data_in;
        reg [5:0] opcode;
        reg MFA;
        reg [7:0] addr;
        wire MFC;        
        wire [31:0] data_out;
        //instantiate RAM module
        ram_256b ram(data_out, MFC, MFA, opcode, addr, data_in);
        initial begin
            
            $display("Writing 2 Bytes 12 on 0x00 and 34 on 0x01");
            data_in = 32'h00000012; //setting data
            addr = 8'h00;   //setting address
            opcode = 6'h05; //setting opcode
            #30;
            MFA <=1'b1; //activate memory
            #100;
            MFA <=0;
           #100;
           
           data_in = 32'h00000034; //setting data
            addr = 8'h01;   //setting address
            opcode = 6'h05; //setting opcode
            #30;
            MFA <=1'b1; //activate memory
            #100;
            MFA <=0;
           #100;
           
           $display("Writing halfword 5678 on 0x02");
           
           data_in = 32'h00005678; //setting data
            addr = 8'h02;   //setting address
            opcode = 6'h06; //setting opcode
            #30;
            MFA <=1'b1; //activate memory
            #100;
            MFA <=0;
           #100;
           
           
           
           $display("reading word on 0x00");
            addr = 8'h00;   //setting address
            opcode = 6'h08; //setting opcode
            #30;
            MFA <=1'b1; //activate memory
            #100;
            $display("data out = %h",data_out);
            MFA <=0;
           #100;
            
              
           
            
        end
endmodule



