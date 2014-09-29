/**************************************
* Module: ramLoadTester
* Date:2014-09-29  
* Author: Derick Moran   
*
* Description: Testing module for RAM preloading from a file.
***************************************/
module  ramLoadTester();
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
        $display("  Preloading memory from file");
        for(i=0;i<256;i=i+1)begin
            ram1.ram[i] = buffer[i[7:0]];
        end
        $display("  Loading words from memory:");
        $display("  address  MFA  MFC   data");
        
        opcode = 6'h08; //setting opcode
        
        for(i=0;i<64;i=i+4) begin
            addr = i[8:0];
            
            #30;
            MFA <=1'b1; //activate memory
            #100;
            
            MFA <=0; // deactivate memory
            #100;
        end
               
    end
    initial $monitor("   0x%h     %d    %d  %h",addr,MFA,MFC,data_out);
endmodule

