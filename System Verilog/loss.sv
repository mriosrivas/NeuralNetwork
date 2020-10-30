`include "typedef.vh"


module loss_square_of_errors #(parameter M = 5)
    (input data_type y_hat[0:M-1][0:0],
    input data_type y[0:M-1][0:0],
    output data_type se[0:M-1][0:0]);
    
    genvar k;
        generate
            for(k=0; k<=M-1; k=k+1) begin
                assign se[k][0] = (y_hat[k][0] - y[k][0])**2;
            end
         endgenerate


endmodule