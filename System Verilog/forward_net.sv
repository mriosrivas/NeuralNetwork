`include "forward_net_header.vh"

module forward_net(
    input logic clk, reset,
    input data_type W1[0:L2-1][0:L1-1],
    input data_type W2[0:L3-1][0:L2-1],
    input data_type W3[0:L4-1][0:L3-1],
    
    input data_type a1[0:L1-1][0:0], //input
    
    input data_type b1[0:L2-1][0:0],
    input data_type b2[0:L3-1][0:0],
    input data_type b3[0:L4-1][0:0],
    
    input data_type y[0:L4-1][0:0],
    
    output data_type a4[0:L4-1][0:0], //output
    output data_type error[0:L4-1][0:0]); 
    
    data_type a2[0:L2-1][0:0];
    data_type a3[0:L3-1][0:0];
    //logic en_acc;
    

    // Forward Neuron Network
    forward_neurons #(L2, L1) layer_1(clk, W1, a1, b1, reset, a2);
    forward_neurons #(L3, L2) layer_2(clk, W2, a2, b2, reset, a3);
    forward_neurons #(L4, L3) layer_3(clk, W3, a3, b3, reset, a4);
    
    // Loss
    loss_square_of_errors #(L4) loss(.y_hat(a4), .y(y), .se(error));
    
    // Accumulator for Cost
    // accumulator #(L4) accumulator(.in(error), .out(acc_error), .clk(clk), .reset(reset), .enable(en_acc));
    
    // Control unit
    // forward_net_control #(16) control(.clk(clk), .reset(reset), .y(en_acc));

 endmodule
 

module forward_net_control #(parameter COUNT = 10)
    (input logic clk,
    input logic reset,
    output logic reset_acc, load);

    typedef enum logic [1:0] {S0, S1, S2} statetype;
    statetype [1:0] state, nextstate;
   
   logic [COUNT:0] counter;
   
   always_ff @(posedge clk)
         if (!reset) counter <= 2**(COUNT-1);
         else counter <= {counter[COUNT-1:0],counter[COUNT]};


    // state register
    always_ff @(posedge clk)
        if (!reset)  state <= S0;
        else state <= nextstate;

  
    // next state logic
    always_comb
        case (state)
            S0: begin 
                nextstate <= S1; 
                reset_acc <= 0;
            end
            S1: begin 
                if (load) nextstate <= S2;
                else nextstate <= S1;
                reset_acc <= 1;
            end
            S2: nextstate <= S1;
            default: nextstate <= S0;
    endcase


    // output logic
    assign load = (counter == 2**COUNT);
    
    

endmodule




//module forward_net(
//    input logic clk, reset,
//    input byte W1[0:L2-1][0:L1-1],
//    input byte W2[0:L3-1][0:L2-1],
//    input byte W3[0:L4-1][0:L3-1],
    
//    input byte a1[0:L1-1][0:0], //input
    
//    input byte b1[0:L2-1][0:0],
//    input byte b2[0:L3-1][0:0],
//    input byte b3[0:L4-1][0:0],
    
//    input byte y[0:L4-1][0:0],
    
//    output byte a4[0:L4-1][0:0], //output
//    output shortint acc_error[0:L4-1][0:0]); 
    
//    byte a2[0:L2-1][0:0];
//    byte a3[0:L3-1][0:0];
//    byte error[0:L4-1][0:0];
//    logic en_acc;
    

//    // Forward Neuron Network
//    forward_neurons #(L2, L1) layer_1(clk, W1, a1, b1, reset, a2);
//    forward_neurons #(L3, L2) layer_2(clk, W2, a2, b2, reset, a3);
//    forward_neurons #(L4, L3) layer_3(clk, W3, a3, b3, reset, a4);
    
//    // Loss
//    loss_square_of_errors #(L4) loss(.y_hat(a4), .y(y), .se(error));
    
//    // Accumulator for Cost
//    accumulator #(L4) accumulator(.in(error), .out(acc_error), .clk(clk), .reset(reset), .enable(en_acc));
    
//    // Control unit
//    forward_net_control #(16) control(.clk(clk), .reset(reset), .y(en_acc));

// endmodule
 

//module forward_net_control #(parameter COUNT = 10)
//    (input logic clk,
//    input logic reset,
//    output logic y);

//    typedef enum logic [1:0] {S0, S1, S2} statetype;
//    statetype [1:0] state, nextstate;
   
//   logic [COUNT:0] counter;
   
//   always_ff @(posedge clk)
//         if (!reset) counter <= 1;
//         else counter <= {counter[COUNT-1:0],counter[COUNT]};


//    // state register
//    always_ff @(posedge clk)
//        if (!reset)  state <= S0;
//        else state <= nextstate;

  
//    // next state logic
//    always_comb
//        case (state)
//            S0: nextstate <= S1;
//            S1: if (y) nextstate <= S2;
//            else nextstate <= S1;
//            S2: nextstate <= S0;
//            default: nextstate <= S0;
//    endcase


//    // output logic
//    assign y = (counter == 2**COUNT);
    
    

//endmodule