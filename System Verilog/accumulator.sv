`include "typedef.vh"

// Sequential accumulator
module accumulator #(parameter M = 5)
    (input data_type in[0:M-1][0:0],
    output double_data_type out[0:M-1][0:0],
    input logic clk,
    input logic reset,
    input logic enable);
    
    genvar k;
        generate
        for(k=0; k<= M-1; k=k+1) begin    
            always_ff @(posedge clk) begin
                if (!reset) out[k][0] <= 0;
                else if (enable) out[k][0] <= out[k][0] + in[k][0];
              end
         end
        endgenerate
endmodule