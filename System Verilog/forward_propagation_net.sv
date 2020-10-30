`include "forward_net_header.vh"
`include "typedef.vh"


module forward_propagation_net(
    input logic clk, reset, enable,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type a1[0:L1-1][0:0], //input
    
    input data_type b1[0:L2-1][0:0],
    input data_type b2[0:L3-1][0:0],
    input data_type b3[0:L4-1][0:0],
    
    input data_type y[0:L4-1][0:0],
    
    output data_type a4[0:L4-1][0:0], //output
    output data_type error[0:L4-1][0:0],
    output double_data_type cost[0:L4-1][0:0]); 
    
    data_type W1_ff[0:L2-1][0:L1-1];
    data_type W2_ff[0:L3-1][0:L2-1];
    data_type W3_ff[0:L4-1][0:L3-1];
    
    data_type a1_ff[0:L1-1][0:0]; //input
    
    data_type b1_ff[0:L2-1][0:0];
    data_type b2_ff[0:L3-1][0:0];
    data_type b3_ff[0:L4-1][0:0];
    
    data_type y_ff[0:L4-1][0:0];
    
    data_type a4_ff[0:L4-1][0:0]; //output
    data_type error_ff[0:L4-1][0:0]; 
    
    logic reset_acc, en_acc, en;
    
    

    // Block of input flip flops
    flip_flop  #(L2, L1) flip_flop_W1(clk, reset, en, W1, W1_ff);
    flip_flop  #(L3, L2) flip_flop_W2(clk, reset, en, W2, W2_ff);
    flip_flop  #(L4, L3) flip_flop_W3(clk, reset, en, W3, W3_ff);
    flip_flop  #(L1, 1) flip_flop_a1(clk, reset, en, a1, a1_ff);
    flip_flop  #(L2, 1) flip_flop_b1(clk, reset, en, b1, b1_ff);
    flip_flop  #(L3, 1) flip_flop_b2(clk, reset, en, b2, b2_ff);
    flip_flop  #(L4, 1) flip_flop_b3(clk, reset, en, b3, b3_ff);
    flip_flop  #(L4, 1) flip_flop_y(clk, reset, en, y, y_ff);
    
    // Forward Network
    forward_net forward_net(.clk(clk), .reset(reset), .W1(W1_ff), .W2(W2_ff), .W3(W3_ff), 
                .a1(a1_ff), .b1(b1_ff), .b2(b2_ff), .b3(b3_ff), .y(y_ff), .a4(a4_ff), .error(error_ff));
    
    // Block of output flip flops
    flip_flop  #(L4, 1) flip_flop_a4(clk, reset, en, a4_ff, a4);
    flip_flop  #(L4, 1) flip_flop_error(clk, reset, en, error_ff, error);
    
    // Loss accumulator
    accumulator #(L4) loss_accumulator(.in(error), .out(cost), .clk(clk), .reset(reset_acc), .enable(en_acc));
    
    // Control unit
    forward_net_control #(16) control(.clk(clk), .reset(reset), .reset_acc(reset_acc), .load(en_acc));
    
    assign en = enable&en_acc; 

 endmodule
 
 
 module flip_flop #(parameter M = 5, parameter N = 3)
        (input logic clk, reset, enable,
        input data_type D[0:M-1][0:N-1],
        output data_type Q[0:M-1][0:N-1]);
        
        
        genvar i, j;
        
        generate
        
        for (i=0; i<=M-1; i=i+1) begin
            for (j=0; j<=N-1; j=j+1) begin
        always_ff @(posedge clk)
            if (!reset) Q[i][j] <= 0;
            else if (enable) Q[i][j] <= D[i][j];
            end
            end
            
        endgenerate
 
 endmodule