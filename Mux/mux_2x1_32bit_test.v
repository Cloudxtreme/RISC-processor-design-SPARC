module  test_mux_2x1;
    reg [31: 0] I0, I1;
    reg [0:0] s;
    wire [31:0]Y;
    
    parameter sim_time = 100;                   //simulation time
    mux_2x1_32bit mux1 (Y, s, I1, I0); //syntax for instanciation
    initial #sim_time $finish;                  //simulation time
    initial begin
        I0 = 32'h00000000;
        I1 = 32'h11111111;
        s = 1'b0;
        repeat (1) #10 s = s + 1'b1;
    end
    initial begin
        $display (" S    I1      I0         Y");
        $monitor (" %b   %h  %h  %h",s,I1,I0,Y);
    end
endmodule
