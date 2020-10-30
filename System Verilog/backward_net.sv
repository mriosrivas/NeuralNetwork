`include "forward_net_header.vh"
`include "typedef.vh"


module backward_net(
    input logic clk, reset,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type z1[0:L2-1][0:0],
    input data_type z2[0:L3-1][0:0],
    input data_type z3[0:L4-1][0:0],
    
    input data_type a1[0:L1-1][0:0], //input
    input data_type a2[0:L2-1][0:0],
    input data_type a3[0:L3-1][0:0],
    
    input data_type da4[0:L4-1][0:0],
    
    output data_type db1[0:L2-1][0:0],
    output data_type db2[0:L3-1][0:0],
    output data_type db3[0:L4-1][0:0],
    
    output data_type dW1[0:L2-1][0:L1-1],
    output data_type dW2[0:L3-1][0:L2-1],
    output data_type dW3[0:L4-1][0:L3-1]); 
    
    data_type da3[0:L3-1][0:0];
    data_type da2[0:L2-1][0:0];
    data_type da1[0:L1-1][0:0];
        

    // Backward Neuron Network
    backward_neurons #(L4, L3) backward_layer_3(.clk(clk), .W(W3), .z(z3), .da_prev(da4), .a(a3), .reset(reset),.da(da3), .db(db3), .dw(dW3));
    backward_neurons #(L3, L2) backward_layer_2(.clk(clk), .W(W2), .z(z2), .da_prev(da3), .a(a2), .reset(reset),.da(da2), .db(db2), .dw(dW2));
    backward_neurons #(L2, L1) backward_layer_1(.clk(clk), .W(W1), .z(z1), .da_prev(da2), .a(a1), .reset(reset),.da(da1), .db(db1), .dw(dW1));
        
    // Loss
    // loss_square_of_errors #(L4) loss(.y_hat(a4), .y(y), .se(error));
    
    // Accumulator for Cost
    // accumulator #(L4) accumulator(.in(error), .out(acc_error), .clk(clk), .reset(reset), .enable(en_acc));
    
    // Control unit
    // forward_net_control #(16) control(.clk(clk), .reset(reset), .y(en_acc));

 endmodule