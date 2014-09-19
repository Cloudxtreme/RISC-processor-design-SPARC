module  test_register_32bit_le_aclr;
    reg [31: 0] I0;
    reg [0:0] loadE, Clk, Clr;
    wire [31:0] Y;
     
    parameter sim_time = 1000;                   //simulation time
    
    register_32bit_le_aclr reg32 (Y, I0, loadE, Clr, Clk); //syntax for instanciation
    initial #sim_time $finish;                  //simulation time
    initial begin
        I0 = 32'h11111111;
        loadE = 1'b0;
        Clr = 1'b0;
        Clk = 1'b0;
        
        //Simulate a clock pulse         
        repeat (1) #10 Clk<=1'b1;  // ___/T
        repeat (1) #10 
            begin
            Clk<=1'b0;
            Clr<=1'b1;
            end
        repeat (1) #10 Clk=1'b1;  // still up
        repeat (1) #10           
            begin
            Clk=1'b0;             // T\___
            loadE=1'b1;
            Clr=1'b0;          
            end
        repeat (1) #10 Clk<=1'b1; //___/T
        repeat (1) #10
            begin
            Clk=1'b0;             // T\___
            Clr=1'b1;
            end
        repeat (1) #10 Clk=1'b1;  // ___/T
        repeat (1) #10 loadE=1'b0;
        
    end
    initial begin
        $display (" E  Clr Clk   I0    Y");
        $monitor (" %b   %h  %h  %h %h", loadE, Clr, Clk, I0, Y);
    end
    
    always begin
    #10 Clk=-Clk;
    end
endmodule