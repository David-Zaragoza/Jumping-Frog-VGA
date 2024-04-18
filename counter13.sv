module thirteen
  #(
    parameter int m=10,  // Maximum
    parameter int b=$clog2(m)  // Bitwidth
    )
   (
    input  logic         inc,
    input  logic         dec,

    input  logic         clk,
    input  logic         rst,

    output logic [b-1:0] cnt
   );

    logic [b-1:0] next;
 
    dflip #(b) my_dff
      (
       .d   (next),
       .q   (cnt),
       .en  (1'b1),
       .clk (clk),
       .rst (rst)
      );

    always_comb begin
      case (1'b1)
        cnt == m - 4'd1  &&  inc && !dec : next =       4'd0;
        cnt ==     4'd0  && !inc &&  dec : next = m -   4'd1;
         inc && !dec                     : next = cnt + 1'b1;
        !inc &&  dec                     : next = cnt - 1'b1;
        default                          : next = cnt;
      endcase
    end

endmodule