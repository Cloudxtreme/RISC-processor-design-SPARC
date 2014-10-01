/**************************************
* Module: ram_tester
* Date:2014-09-27  
* Author: Derick Moran     
*
* Description:  Testing module for the 256x32 RAM.
*               This test focuses on testing the 
*               different opcodes for load and 
*               store instructions.
***************************************/
module  ram_tester;
  
    integer i;
    reg [7:0] buffer[0:255]; 
    reg [31:0] data_in;
    reg [5:0] opcode;
    reg MFA;
    reg [7:0] addr;
    wire MFC;        
    wire [31:0] data_out;
    //instantiate RAM module
    ram_256b ram1(data_out, MFC, MFA, opcode, addr, data_in);
    initial begin
        //preparing data buffer
        i = 0;
        $readmemh("file.dat",buffer);
        ram1.ram[i] = buffer[i[7:0]];
        //$display("data from file = %b",buffer[i]);
        
        //testing store byte
        
        $display("\n==============================================");
        $display("  Now testing Store Byte");
        $display("  Writing 2 Bytes 01h on 0x00 and 23h on 0x01");
        data_in = 32'h00000001; //setting data
        addr = 8'h00;   //setting address
        opcode = 6'h05; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        MFA <=0;
        #100;
        
        data_in = 32'h00000023; //setting data
        addr = 8'h01;   //setting address
        opcode = 6'h05; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        MFA <=0;
        #100;
        $display("==============================================");
        
        
        // testing store halfword
        $display("\n==============================================");
        $display("  Now testing Store Halfword");
        $display("  Writing halfword 4567h on 0x02");
        data_in = 32'h00004567; //setting data
        addr = 8'h02;   //setting address
        opcode = 6'h06; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        MFA <=0;
        #100;
        $display("==============================================");
        
        
        // testing store word
        $display("\n==============================================");
        $display("  Now testing Store Word");
        $display("  Writing word 89abcdef on 0x04");
        data_in = 32'h123abcdf; //setting data
        addr = 8'h04;   //setting address
        opcode = 6'h04; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        MFA <=0;
        #100;
        $display("==============================================");
        
        
        //testing load unsigned byte
        $display("\n==============================================");
        $display("  Now testing Load Unsigned Byte");
        $display("reading byte on 0x00");
        addr = 8'h00;   //setting address
        opcode = 6'h01; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        
        $display("reading byte on 0x04");
        addr = 8'h04;   //setting address
        opcode = 6'h01; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        $display("==============================================");
        
        
        
        //testing load signed byte
        $display("\n==============================================");
        $display("  Now testing Load Signed Byte");
        $display("reading positive byte on 0x00");
        addr = 8'h00;   //setting address
        opcode = 6'h09; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        
        $display("reading negative byte on 0x06");
        addr = 8'h06;   //setting address
        opcode = 6'h09; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        $display("==============================================");
        //0123456789abcdef
        
        //testing load unsigned halfword
        $display("\n==============================================");
        $display("  Now testing Load Unsigned Halfword");
        $display("reading halfword on 0x03");
        addr = 8'h03;   //setting address
        opcode = 6'h02; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        
        $display("reading halfword on 0x06");
        addr = 8'h06;   //setting address
        opcode = 6'h02; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        $display("==============================================");
        
        //testing load signed halfword
        $display("\n==============================================");
        $display("  Now testing Load Signed Halfword");
        $display("reading positive halfword on 0x02");
        addr = 8'h02;   //setting address
        opcode = 6'h0a; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        
        $display("reading negative halfword on 0x06");
        addr = 8'h06;   //setting address
        opcode = 6'h0a; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        $display("==============================================");
        
        
        //testing load word
        $display("\n==============================================");
        $display("  Now testing Load Word");
        $display("reading word on 0x00");
        addr = 8'h00;   //setting address
        opcode = 6'h08; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        
        $display("reading word on 0x04");
        addr = 8'h04;   //setting address
        opcode = 6'h08; //setting opcode
        #30;
        MFA <=1'b1; //activate memory
        #100;
        $display("data out = %h",data_out);
        MFA <=0;
        #100;
        $display("==============================================\n");
        
        
        
    end
endmodule

