// This file is used to connect the hardware speed module with the dcache

`include "defines.sv"

module cache_interface(
	input 			clk,
	input           	reset,

	// from externel input 
	input scalar_t          base_addr,
	input scalar_t          depth,
	input                   interface_req,

	// from dcache_data_stage
	input                   dcache_response,
	input                   dcache_complete,
	
	//  To thread_select_stage 
	output   logic          pipeline_stall,				

	// to dcache_tag_stage
	output  logic           dcache_interface_req

);

logic [3:0] count;
always_ff@(posedge clk ,posedge reset)
begin
	if(reset)
	begin
		count <=0;
	end
	else begin
		count <= count +1;
	end
end

assign pipeline_stall = count >4 ? 1'b1:1'b0;

endmodule
