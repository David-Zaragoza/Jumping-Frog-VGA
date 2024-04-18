module checks #(
    parameter int pA = 10,
    parameter int fA = 32,
    parameter int cA = 4
)
(
    input  logic [pA-1:0] pix_x,
    input  logic [pA-1:0] pix_y,
    input  logic          pix_v,
    input  logic [fA-1:0] frame_id,
    output logic [cA-1:0] color[2:0],
    input  logic          clk,
    input  logic          rst,
	 input  logic SW1
);

    logic [18:0] v1;
	 
    logic [27:0] count;
    
	 logic count1, count2, count3, count4, count5, count6;
	 
    logic [11:0] pixelfrog;
	 
	 logic [11:0] pixelfrog1;
	 logic [11:0] pixelfrog2;
	 logic [11:0] pixelfrog3;
	 logic [11:0] pixelfrog4;
	 logic [11:0] pixelfrog5;
	 logic [11:0] pixelfrog6;
	 

      (* ram_init_file = "pixelfrog1.mif" *) logic[11:0] mem1[12287:0];
     assign pixelfrog1 = mem1[v1];
	   (* ram_init_file = "pixelfrog2.mif" *) logic[11:0] mem2[12287:0];
     assign pixelfrog2 = mem2[v1];
	   (* ram_init_file = "pixelfrog3.mif" *) logic[11:0] mem3[12287:0];
     assign pixelfrog3 = mem3[v1];
	   (* ram_init_file = "pixelfrog4.mif" *) logic[11:0] mem4[12287:0];
     assign pixelfrog4 = mem4[v1];
	   (* ram_init_file = "pixelfrog5.mif" *) logic[11:0] mem5[12287:0];
     assign pixelfrog5 = mem5[v1];
	  (* ram_init_file = "pixelfrog6.mif" *) logic[11:0] mem6[12287:0];
     assign pixelfrog6 = mem6[v1];
	  


     thirteen #(120_000_000) counter (.clk, .rst, .inc(1'b1), .dec(1'b0), .cnt(count));


     assign count1 = (count <= 20_000_000) ? 1'b1 : 1'b0;
     assign count2 = (count >= 40_000_000 &&  count  <= 20_000_000)  &&  SW1 ?  1'b1 : 1'b0;
     assign count3 = (40_000_000 >= count &&  count  <= 60_000_000)  &&  SW1 ?  1'b1 : 1'b0;
     assign count4 = (60_000_000 >= count &&  count  <= 80_000_000) &&  SW1 ?  1'b1 : 1'b0;
	  assign count5 = (80_000_000 >= count &&  count  <= 100_000_000)  &&  SW1 ?  1'b1 : 1'b0;
     assign count6 = (100_000_000 >= count &&  count  <= 120_000_000) &&  SW1 ?  1'b1 : 1'b0;
 

    always_comb begin
            priority case (1'b1)
                    count1 : pixelfrog = pixelfrog1;
                    count2 : pixelfrog = pixelfrog2;
                    count3 : pixelfrog = pixelfrog3;
                    count4 : pixelfrog = pixelfrog4;
						  count5 : pixelfrog = pixelfrog5;
						  count6 : pixelfrog = pixelfrog6;
            endcase
    end

     assign v1 = (pix_x / 5) + ((pix_y / 5)*128);

    assign color[1] = pix_v ? pixelfrog[3:0]  : 0;
    assign color[0] = pix_v ? pixelfrog[7:4]  : 0;
    assign color[2] = pix_v ? pixelfrog[11:8] : 0;

endmodule // checkers