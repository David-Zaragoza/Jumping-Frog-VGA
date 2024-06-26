
module Lab5_MTDZ
   (
    output logic [3:0] VGA_RED,
    output logic [3:0] VGA_BLUE,
    output logic [3:0] VGA_GREEN,
    output logic       VGA_HS,
    output logic       VGA_VS,
	 input  logic       SW1,
    input  logic       clk,
    input  logic       rst 
    );

   parameter int       pA = 12 ; // Pixel address bits
   parameter int       fA = 32 ; // Frame ID bits
   parameter int       cA = 4  ; // Color bits
   parameter int       cM = 15 ; // Max Color
   
   logic [pA-1:0]      pix_x ; // Image space pixel address
   logic [pA-1:0]      pix_y ; // Image space pixel address
   logic [fA-1:0]      frame_id ; // The Frame id 
   logic               pix_v ; // Pixel address in pixel space

   logic [cA-1:0]      color[2:0];
   logic hs,vs,my_clk;
   
   logic 	       rst_l ;

   assign rst_l = rst ;

   // Flop Outputs
   my_dff #(4) d01(.din(color[0]),.clk(my_clk),.rst(rst_l),.en(1'b1),.q(VGA_RED));
   my_dff #(4) d02(.din(color[1]),.clk(my_clk),.rst(rst_l),.en(1'b1),.q(VGA_GREEN));
   my_dff #(4) d03(.din(color[2]),.clk(my_clk),.rst(rst_l),.en(1'b1),.q(VGA_BLUE));
   my_dff #(2) d04(.din({hs,vs}) ,.clk(my_clk),.rst(rst_l),.en(1'b1),.q({VGA_HS,VGA_VS}));
	 

   //assign VGA_RED = color[0];
   //assign VGA_GREEN = color[1];
   //assign VGA_BLUE = color[2];
   //assign {VGA_HS,VGA_VS} = {hs,vs};
   
   vgaControl #(pA,fA) vgaDriver( .pix_x(pix_x), 
			      .pix_y(pix_y), 
			      .pix_v(pix_v),
			      .frame_id(frame_id),
			      .hs(hs), 
			      .vs(vs), 
			      .clk(my_clk), 
			      .rst(rst_l) );
 
   // Produce a checker board pattern from pixel addresses
   checks #(pA,fA,cA)    getChecky( .pix_x(pix_x),
				      .pix_y(pix_y),
				      .pix_v(pix_v),
				      .frame_id(frame_id),
				      .color(color),
						.SW1(SW1),
				      .clk(my_clk),
				      .rst(rst_l) );
						
	clock clk1(.clk(clk),.rst_l(rst_l),.my_clk(my_clk));
 
endmodule //rasterDemo


 

    
   
   
