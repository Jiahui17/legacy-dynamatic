//-----------------------------------------------------------------------
//-- int add, version 0.0
//-----------------------------------------------------------------------
module add_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] + data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule



//-----------------------------------------------------------------------
//-- int sub, version 0.0
//-----------------------------------------------------------------------
//If data_in_bus contains two data a and b of 32 bit width such that data_in_bus = {a, b}, then sub_op returns b - a as the answer
module sub_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] - data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule


//-----------------------------------------------------------------------
//-- int multiply, version 0.0
//-----------------------------------------------------------------------
//If data_in_bus contains two data a and b of 32 bit width such that data_in_bus = {a, b}, then sub_op returns b * a as the answer
module mul_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input 	[OUTPUTS - 1 : 0] ready_out_bus
);
	localparam LATENCY = 4;
	
	wire [2 * DATA_OUT_SIZE - 1 : 0] temp_result;
	
	
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain;
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(join_valid), .ready_out(oehb_ready));
	
	mul_4_stage multiply_unit (.clk(clk), .ce(oehb_ready), .a(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]), .b(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]), .p(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE]));
	
	delay_buffer #(.SIZE(LATENCY - 1))delay_buff(.clk(clk), .rst(rst), .valid_in(join_valid), .ready_in(oehb_ready), .valid_out(buff_valid));
	
	OEHB #(.INPUTS(1), .OUTPUTS(1), .DATA_IN_SIZE(1), .DATA_OUT_SIZE(1)) oehb_buffer (.clk(clk), .rst(rst),
										 .data_in_bus(1'b0), .valid_in_bus(buff_valid), .ready_in_bus(oehb_ready),
										 .data_out_bus(oehb_dataOut), .valid_out_bus(valid_out_bus[0]), .ready_out_bus(ready_out_bus[0]));
	


endmodule



//-----------------------------------------------------------------------
//-- logical and, version 0.0
//-----------------------------------------------------------------------
module and_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] & data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule



//-----------------------------------------------------------------------
//-- logical or, version 0.0
//-----------------------------------------------------------------------
module or_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] | data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule




//-----------------------------------------------------------------------
//-- logical xor, version 0.0
//-----------------------------------------------------------------------
module xor_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] ^ data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule


//Sext and Zext to be included. What are they anyway?
//Is Sext for converting Unsigned data to signed data?
//Is zext doing the same thing?

module sext_op #(parameter INPUTS = 1,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output  [INPUTS - 1 : 0] ready_in_bus,
		
		output signed [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output  [OUTPUTS - 1 : 0]valid_out_bus,
		input 	[OUTPUTS - 1 : 0] ready_out_bus
);

	assign data_out_bus = data_in_bus;
	assign valid_out_bus = valid_in_bus;
	assign ready_in_bus = ready_out_bus;
	
	//always @(*)begin
	//	data_out_bus = data_in_bus;
	//end
	
	
endmodule


module zext_op #(parameter INPUTS = 1,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output  [INPUTS - 1 : 0] ready_in_bus,
		
		output signed [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output  [OUTPUTS - 1 : 0]valid_out_bus,
		input 	[OUTPUTS - 1 : 0] ready_out_bus
);

	assign data_out_bus = data_in_bus;
	assign valid_out_bus = valid_in_bus;
	assign ready_in_bus = ready_out_bus;
	
	//always @(*)begin
	//	data_out_bus = data_in_bus;
	//end
	
	
endmodule


//-----------------------------------------------------------------------
//-- shl, version 0.0
//-----------------------------------------------------------------------
module shl_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));
	
	wire [DATA_IN_SIZE - 1 : 0]temp1, temp0;
	assign temp1 = data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];
	assign temp0 = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE];
	
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = temp0 << temp1;

endmodule




//-----------------------------------------------------------------------
//-- lshr, version 0.0
//-----------------------------------------------------------------------
module lshr_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));
	
	wire [DATA_IN_SIZE - 1 : 0]temp1, temp0;
	assign temp1 = data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];
	assign temp0 = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE];
	
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = temp0 >> temp1;

endmodule




//-----------------------------------------------------------------------
//-- ashr, version 0.0
//-----------------------------------------------------------------------
module ashr_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));
	
	wire signed [DATA_IN_SIZE - 1 : 0]temp0;// ">>>" Won't work in verilog without signed data tyoe
	wire [DATA_IN_SIZE - 1 : 0]temp1;
	assign temp1 = data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];
	assign temp0 = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE];
	
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = temp0 >>> temp1;

endmodule


//-----------------------------------------------------------------------
//-- Select, version 0.0
//-----------------------------------------------------------------------
//-- llvm select: operand(0) is condition, operand(1) is true, operand(2) is false
//-- here, dataInArray(0) is true, dataInArray(1) is false operand
//Since condition of select is always 1 bit wide, we will use a 32 bit bus for it 
//But utilize only the LSB of that bus for condition
//data_in_bus --> {32'bdataFalse, 32'bdataTrue, 32'bCondition}
module select_op #(parameter INPUTS = 3,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	
	reg antitoken1, antitoken2;
	wire sel, ee, out_transfer; 
	assign sel = data_in_bus[0];

	// select has a valid token to send
	assign ee = sel ? (valid_in_bus[0] && valid_in_bus[1]) : (valid_in_bus[0] && valid_in_bus[2]);


	// transfer is allowed only if the antitokens from the previous round are all used.
	assign valid_out_bus[0] = ee & ~antitoken1 & ~antitoken2;
	assign out_transfer = valid_out_bus[0] & ready_out_bus[0];

	// ready to accept data when transfer is possible
	assign ready_in_bus[0] = (~valid_in_bus[0]) || out_transfer;

	// ready to accept data when transfer is possible, or antitoken can cancel discarded token
	assign ready_in_bus[1] = (~valid_in_bus[1]) || out_transfer || antitoken1;

	// ready to accept data when transfer is possible, or antitoken can cancel discarded token
	assign ready_in_bus[2] = (~valid_in_bus[2]) || out_transfer || antitoken2;

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = sel ? data_in_bus[ 1 * DATA_IN_SIZE +: DATA_IN_SIZE ] : data_in_bus[ 2 * DATA_IN_SIZE +: DATA_IN_SIZE ];
	

	always@(posedge clk)
		if (rst)
			antitoken1 <= 0;
		else
			antitoken1 <= ~valid_in_bus[1] && (antitoken1 || out_transfer);

	always@(posedge clk)
		if (rst)
			antitoken2 <= 0;
		else
			antitoken2 <= ~valid_in_bus[2] && (antitoken2 || out_transfer);
endmodule




//-----------------------------------------------------------------------
//-- icmp eq, version 0.0
//-----------------------------------------------------------------------
module icmp_eq_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] == data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule




//-----------------------------------------------------------------------
//-- icmp ne, version 0.0
//-----------------------------------------------------------------------
module icmp_ne_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] != data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule




//-----------------------------------------------------------------------
//-- ugt, version 0.0
//-----------------------------------------------------------------------
module icmp_ugt_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] > data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule




//-----------------------------------------------------------------------
//-- icmp uge, version 0.0
//-----------------------------------------------------------------------
module icmp_uge_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] >= data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule




//-----------------------------------------------------------------------
//-- sgt, version 0.0
//-----------------------------------------------------------------------
module icmp_sgt_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));
	
	wire signed [DATA_IN_SIZE - 1 : 0] dat1, dat0;
	
	assign dat0 = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE];
	assign dat1 = data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = dat0 > dat1;

endmodule




//-----------------------------------------------------------------------
//-- icmp sge, version 0.0
//-----------------------------------------------------------------------
module icmp_sge_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));
	
	wire signed [DATA_IN_SIZE - 1 : 0] dat1, dat0;
	
	assign dat0 = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE];
	assign dat1 = data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = dat0 >= dat1;

endmodule




//-----------------------------------------------------------------------
//-- ult, version 0.0
//-----------------------------------------------------------------------
module icmp_ult_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] < data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule




//-----------------------------------------------------------------------
//-- icmp ule, version 0.0
//-----------------------------------------------------------------------
module icmp_ule_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE] <= data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

endmodule




//-----------------------------------------------------------------------
//-- slt, version 0.0
//-----------------------------------------------------------------------
module icmp_slt_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));
	
	wire signed [DATA_IN_SIZE - 1 : 0] dat1, dat0;
	
	assign dat0 = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE];
	assign dat1 = data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = dat0 < dat1;

endmodule

//-----------------------------------------------------------------------
//-- icmp sle, version 0.0
//-----------------------------------------------------------------------
module icmp_sle_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);
	
	joinC #(.N(INPUTS)) add_fork(.valid_in(valid_in_bus), .ready_in(ready_in_bus), .valid_out(valid_out_bus), .ready_out(ready_out_bus));
	
	wire signed [DATA_IN_SIZE - 1 : 0] dat1, dat0;
	
	assign dat0 = data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE];
	assign dat1 = data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE];

	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = dat0 <= dat1;

endmodule


// TODO: for now, I set fcmp_ueq_op to be the same as fcmp_oeq_op (same for
// 5 other ones)

module fcmp_ueq_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U5(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd1),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_uge_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U12(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd3),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_ugt_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U9(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd2),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_ult_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U15(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd4),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_ule_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U18(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd5),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_une_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U21(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd1),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

/////////////////////////////////

module fcmp_oeq_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U5(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd1),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_oge_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U12(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd3),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_ogt_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U9(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd2),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_olt_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U15(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd4),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_ole_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U18(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd5),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fcmp_one_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 1;
	wire join_valid;
	wire oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	wire fcmp_out;
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = fcmp_out; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fcmp_32ns_32ns_1_2_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 1 ))
		dynamatic_units_fcmp_32ns_32ns_1_2_1_U21(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.opcode(5'd1),
			.dout(fcmp_out)
		); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(join_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fadd_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	localparam LATENCY = 9;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain;

	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready));

	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fadd_32ns_32ns_32_10_full_dsp_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_fadd_32ns_32ns_32_10_full_dsp_1_U24(
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		);

	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid));
	
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule



module fsub_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	localparam LATENCY = 9;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain;

	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready));

	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fsub_32ns_32ns_32_10_full_dsp_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_fsub_32ns_32ns_32_10_full_dsp_1_U28 (
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		);

	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid));
	
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module fmul_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	localparam LATENCY = 5;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain;

	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready));

	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fmul_32ns_32ns_32_6_max_dsp_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_fmul_32ns_32ns_32_6_max_dsp_1_U32 (
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		);

	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid));
	
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule


module udiv_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	localparam LATENCY = 35;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain;

	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready));

	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_udiv_32ns_32ns_32_36_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_udiv_32ns_32ns_32_36_1_U36 (
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		);

	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid));
	
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule



module sdiv_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	localparam LATENCY = 35;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain;

	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready));

	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_sdiv_32ns_32ns_32_36_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_sdiv_32ns_32ns_32_36_1_U40 (
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		);

	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid));
	
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule


module fdiv_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
);

	localparam LATENCY = 29;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain;

	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready));

	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fdiv_32ns_32ns_32_30_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_fdiv_32ns_32ns_32_30_1_U44 (
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		);

	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid));
	
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module srem_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 35;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_srem_32ns_32ns_32_36_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_srem_32ns_32ns_32_36_1_U48 (
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		); 
	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid)); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module urem_op #(parameter INPUTS = 2,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 35;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	joinC #(
		.N(INPUTS))
		j0 (
			.valid_in(valid_in_bus),
			.ready_in(ready_in_bus),
			.valid_out(join_valid),
			.ready_out(oehb_ready)); 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_urem_32ns_32ns_32_36_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_urem_32ns_32ns_32_36_1_U52 (
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.din1(data_in_bus[1 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		); 
	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid)); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module sqrtf_op #(parameter INPUTS = 1,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 27;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	//
	assign join_valid = valid_in_bus;
	assign ready_in_bus = oehb_ready; 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fsqrt_32ns_32ns_32_28_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_fsqrt_32ns_32ns_32_28_1_U80 (
			.clk(clk),
			.reset(rst),
			.din0(32'd0),
			.din1(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		); 
	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid)); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module expf_op #(parameter INPUTS = 1,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 17;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	//
	assign join_valid = valid_in_bus;
	assign ready_in_bus = oehb_ready; 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_fexp_32ns_32ns_32_18_full_dsp_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_fexp_32ns_32ns_32_18_full_dsp_1_U83 (
			.clk(clk),
			.reset(rst),
			.din0(32'd0),
			.din1(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		); 
	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid)); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

module logf_op #(parameter INPUTS = 1,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 18;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	//
	assign join_valid = valid_in_bus;
	assign ready_in_bus = oehb_ready; 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_flog_32ns_32ns_32_19_full_dsp_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.din1_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_flog_32ns_32ns_32_19_full_dsp_1_U94 (
			.clk(clk),
			.reset(rst),
			.din0(32'd0),
			.din1(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		); 
	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid)); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule

// TODO: log10f is logf and fmul
// TODO: fminf
// TODO: fmaxf

module sitofp_op #(parameter INPUTS = 1,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus, 
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input [OUTPUTS - 1 : 0] ready_out_bus
); 
	localparam LATENCY = 5;
	wire join_valid;
	wire buff_valid, oehb_valid, oehb_ready;
	wire oehb_dataOut, oehb_datain; 
	//
	assign join_valid = valid_in_bus;
	assign ready_in_bus = oehb_ready; 
	// remark: NUM_STAGE = LATENCY + 1
	dynamatic_units_sitofp_32ns_32_6_1 #(
		.ID( 1 ),
		.NUM_STAGE( LATENCY + 1 ),
		.din0_WIDTH( 32 ),
		.dout_WIDTH( 32 ))
		dynamatic_units_sitofp_32ns_32_6_1_U158 (
			.clk(clk),
			.reset(rst),
			.din0(data_in_bus[0 * DATA_IN_SIZE +: DATA_IN_SIZE]),
			.ce(oehb_ready),
			.dout(data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE])
		); 
	delay_buffer #(
		.SIZE(LATENCY - 1))
		d0 (
			.clk(clk),
			.rst(rst),
			.valid_in(join_valid),
			.ready_in(oehb_ready),
			.valid_out(buff_valid)); 
	OEHB #(
		.INPUTS(1),
		.OUTPUTS(1),
		.DATA_IN_SIZE(1),
		.DATA_OUT_SIZE(1))
		oehb_buffer (
			.clk(clk),
			.rst(rst),
			.data_in_bus(1'b0),
			.valid_in_bus(buff_valid),
			.ready_in_bus(oehb_ready),
			.data_out_bus(oehb_dataOut),
			.valid_out_bus(valid_out_bus[0]),
			.ready_out_bus(ready_out_bus[0])
		); 
endmodule







module getelementptr_op #(parameter INPUTS = 3,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32,
		parameter CONST_SIZE = 1)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output  [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input 	[OUTPUTS - 1 : 0] ready_out_bus
);

	reg [DATA_IN_SIZE - 1 : 0] data_in[INPUTS - 1 : 0];
	reg [INPUTS - 1 : 0] valid_in = 0;
	wire [INPUTS - 1 : 0] ready_in;
	
	wire [DATA_OUT_SIZE - 1 : 0] data_out[OUTPUTS - 1 : 0];
	wire [OUTPUTS - 1 : 0]valid_out;
	reg [OUTPUTS - 1 : 0]ready_out = 0;
	
	integer temp_const = 1, temp_mul = 0;
	integer temp_data_out = 0;//Does it have to be unsigned?
	
	integer i, j;

	/*always @(*) begin
		for(i = INPUTS - 1; i >= 0; i = i - 1) begin
			//data_in[i] = data_in_bus[(i + 1) * DATA_IN_SIZE - 1 -: DATA_IN_SIZE];
			valid_in[i] = valid_in_bus[i];
			ready_in_bus[i] = ready_in[i];
		end
	end
	
	
	always @(*)begin
		for(i = OUTPUTS - 1; i >= 0; i = i - 1) begin
			//data_out_bus[(i + 1) * DATA_OUT_SIZE - 1 -: DATA_OUT_SIZE] = data_out[i];
			valid_out_bus[i] = valid_out[i];
			ready_out[i] = ready_out_bus[i];
		end
	end*/
	
	
	always @(*)begin
		temp_data_out = 0;
		for(i = 0; i < INPUTS - CONST_SIZE; i = i + 1)begin
			temp_const = 1;
			for(j = INPUTS - CONST_SIZE + i; j < INPUTS; j = j + 1)
				temp_const = temp_const * data_in_bus[j * DATA_IN_SIZE +: DATA_IN_SIZE];
			temp_mul = data_in_bus[i * DATA_IN_SIZE +: DATA_IN_SIZE] * temp_const;
			temp_data_out = temp_data_out + temp_mul;
		end
	end
	
	
	joinC #(.N(INPUTS - CONST_SIZE)) getPtrJoin (.valid_in(valid_in_bus[INPUTS - CONST_SIZE - 1 : 0]),
					.ready_in(ready_in_bus[INPUTS - CONST_SIZE - 1 : 0]),
					.valid_out(valid_out_bus[0]),
					.ready_out(ready_out_bus[0]));
					
	assign ready_in_bus[INPUTS - 1 : INPUTS - CONST_SIZE] = {CONST_SIZE{1'b1}};
	
	//assign data_out_bus = data_out[0];
	assign data_out_bus[0 * DATA_OUT_SIZE +: DATA_OUT_SIZE] = temp_data_out[DATA_OUT_SIZE - 1 : 0];
	
endmodule





//-----------------------------------------------------------------------
//-- return, version 0.0
//-----------------------------------------------------------------------
module ret_op #(parameter INPUTS = 1,
		parameter OUTPUTS = 1,
		parameter DATA_IN_SIZE = 32,
		parameter DATA_OUT_SIZE = 32)
		(
		input clk,
		input rst,
		input [INPUTS * (DATA_IN_SIZE)- 1 : 0]data_in_bus,
		input [INPUTS - 1 : 0]valid_in_bus,
		output [INPUTS - 1 : 0] ready_in_bus,
		
		output [OUTPUTS * (DATA_OUT_SIZE) - 1 : 0]data_out_bus,
		output [OUTPUTS - 1 : 0]valid_out_bus,
		input 	[OUTPUTS - 1 : 0] ready_out_bus
);

	TEHB #(.INPUTS(1), .OUTPUTS(1), .DATA_IN_SIZE(DATA_IN_SIZE), .DATA_OUT_SIZE(DATA_OUT_SIZE)) ret_tehb
	(
		.clk(clk), .rst(rst),
		.data_in_bus(data_in_bus), .valid_in_bus(valid_in_bus), .ready_in_bus(ready_in_bus),
		.data_out_bus(data_out_bus), .valid_out_bus(valid_out_bus), .ready_out_bus(ready_out_bus)
	);
	
endmodule
