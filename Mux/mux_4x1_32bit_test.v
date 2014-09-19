module  test_mux_2x1;
    reg [31: 0] I0, I1, I2, I3;
    reg [1:0] s;
    wire [31:0]Y;
    
    parameter sim_time = 100;                   //simulation time
    mux_4x1_32bit mux1 (Y, s, I3, I2, I1, I0); //syntax for instanciation
    initial #sim_time $finish;                  //simulation time
    initial begin
        I0 = 32'h00000000;
        I1 = 32'h00001111;
        I2 = 32'h11110000;
        I3 = 32'h11111111;
        
        s = 2'b00;
        repeat (3) #10 s = s + 2'b01;
    end
    initial begin
        $display (" S    I3       I2        I1       I0         Y");
        $monitor (" %b   %h  %h  %h %h %h",s,I3,I2,I1,I0,Y);
    end
endmodule
