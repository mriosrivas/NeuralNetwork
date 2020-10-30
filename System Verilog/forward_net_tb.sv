`include "forward_net_header.vh"

module forward_net_tb();
    logic clk, reset;
    byte W1[0:L2-1][0:L1-1];
    byte W2[0:L3-1][0:L2-1];
    byte W3[0:L4-1][0:L3-1];
    
    byte a1[0:L1-1][0:0]; //input
    
    byte b1[0:L2-1][0:0];
    byte b2[0:L3-1][0:0];
    byte b3[0:L4-1][0:0];
    
    byte a4[0:L4-1][0:0];
    
    
    forward_net dut(.clk(clk), .reset(clk), .W1(W1), .W2(W2), .W3(W3), .a1(a1), .b1(b1), .b2(b2), .b3(b3), .a4(a4));
    
     // generate clock
    always
        begin
            clk = 1; #5; clk = 0; #5;
        end
    
    // apply inputs one at a time
    // checking results
    initial begin
    reset = 0;
    #25 reset = 1;
    
    W1[0][0]=3;
    W1[0][1]=1;
    W1[0][2]=8;
    W1[1][0]=3;
    W1[1][1]=-6;
    W1[1][2]=3;
    W1[2][0]=-10;
    W1[2][1]=-1;
    W1[2][2]=-8;
    W1[3][0]=-5;
    W1[3][1]=6;
    W1[3][2]=3;
    W2[0][0]=5;
    W2[0][1]=8;
    W2[0][2]=-8;
    W2[0][3]=6;
    W2[1][0]=-4;
    W2[1][1]=-8;
    W2[1][2]=3;
    W2[1][3]=7;
    W3[0][0]=9;
    W3[0][1]=5;
    b1[0][0]=3;
    b1[1][0]=1;
    b1[2][0]=8;
    b1[3][0]=3;
    b2[0][0]=3;
    b2[1][0]=-10;
    b3[0][0]=-8;
        
    end
    
endmodule