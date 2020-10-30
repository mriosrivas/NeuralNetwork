/*
* neurons.sv
* created by : Manuel Rios
* date: 18-Aug-20

* Module forward_neurons
* Functionality:
* calculates the forward propagation of an array of M neurons
* input ports:
* A: matrix of dimension M by N
* x: vector of dimension N by 1
* b: bias vector of dimension M by 1
* clk: clock signal
* reset: system reset, low asserted
* output ports:
* a: activation vector of dimension M by 1
*/
`include "typedef.vh"


module forward_neurons #(parameter M = 5, parameter N = 3) 
    (input logic clk,
    input data_type A[0:M-1][0:N-1],
    input data_type x[0:N-1][0:0],
    input data_type b[0:M-1][0:0],
    input logic reset,
    output data_type a[0:M-1][0:0]);
    
    data_type Ax[0:M-1][0:0];
    data_type z[0:M-1][0:0];
    
    
mult #(M, N) multiplier(.clk(clk), .A(A), .x(x), .reset(reset), .b(Ax));

bias #(M) add_bias(.clk(clk), .z(Ax), .b(b), .reset(reset), .a(z));
   
relu #(M) activation(.clk(clk), .z(z), .reset(reset), .a(a));  
    
endmodule

/*
* Module backward_neurons
* Functionality:
* calculates the backward propagation of an array of M neurons
* input ports:
* W: matrix of dimension M by N
* dz: gradient vector of dimension M by 1
* a: activation vector of dimension N by 1
* clk: clock signalhttps://docs.google.com/document/d/1SKmEhFQkMPfgcsnGQpgSH0rENY1Otq66CcVw5m_jZvI/edit?usp=sharing
* reset: system reset, low asserted
* output ports:
* da: activaiton gradient vector of dimension N by 1
* db: bias gradient vector of dimension M by 1
* weight gradient matrix of dimension M by N
*/

//M: Number of Rows
//N: Number of Columns

module backward_neurons #(parameter M = 5, parameter N = 3) 
    (input logic clk,
    input data_type W[0:M-1][0:N-1],
    input data_type z[0:M-1][0:0],
    input data_type da_prev[0:M-1][0:0],
    input data_type a[0:N-1][0:0],
    input logic reset,
    output data_type da[0:N-1][0:0],
    output data_type db[0:M-1][0:0],
    output data_type dw[0:M-1][0:N-1]);
    
    data_type a_t[0:0][0:N-1];
    data_type W_t[0:N-1][0:M-1];
    data_type dz[0:M-1][0:0];
 
// Relu back-drop
// dz = da[Z<=0] = 0    

// z input
// da input
// dz output
relu_backdrop #(M) relu_backdrop(.clk(clk), .z(z), .da(da_prev), .reset(reset), .dz(dz));
 
transpose #(N,1) transpose_a(.A(a), .A_t(a_t));
vector_mult #(M,N) vector_mult_dw(.clk(clk), .V(dz), .U(a_t), .reset(reset), .VU(dw));

transpose #(M, N) transpose_W(.A(W), .A_t(W_t));
mult #(N, M) multiplier_da(.clk(clk), .A(W_t), .x(dz), .reset(reset), .b(da));

assign db = dz;
    
endmodule