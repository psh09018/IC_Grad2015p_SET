module SET (clk ,rst, en,central,radius, mode, busy, valid, candidate);
input clk;
input rst;
input en;
input [23:0] central;
input [11:0] radius;
input [1:0] mode;
output reg busy;
output reg valid;
output reg [7:0]candidate;

reg [3:0] x;
reg [3:0] y;

reg [7:0] dis;
reg d_r1;  //<=:0 / >:1
reg d_r2;
reg d_r3;

reg [3:0] state;
parameter initialization = 4'd0; 
parameter get_dis1_1 = 4'd1;
parameter get_dis1_2 = 4'd2;
parameter get_dis1_3 = 4'd3;
parameter get_dis1 = 4'd4;
parameter get_dis2_1 = 4'd5;
parameter get_dis2_2 = 4'd6;
parameter get_dis2 = 4'd7;
parameter get_dis3_1 = 4'd8;
parameter get_dis3_2 = 4'd9;
parameter get_dis3 = 4'd10;
parameter decide_candidate = 4'd11;
parameter counter = 4'd12;


reg signed [3:0] a;
wire [7:0] multiplier = a * a;

always @(posedge clk or posedge rst) begin
	if(rst) begin
		x<=4'd0;
		y<=4'd0;
		d_r1<=0;
		d_r2<=0;
		d_r3<=0;
		busy<=0;
		valid<=0;
		candidate<=8'd0;
		state<=initialization;
	end
	else begin
		case(state)
			initialization: begin
				valid<=0;
				candidate<=8'd0;
				x<=4'd1;
				y<=4'd1;
				if(en) begin
					busy<=1;
					state<=get_dis1_1;
				end
			end
			get_dis1_1: begin
				a <= x-central[23:20];
				state <= get_dis1_2;
			end
			get_dis1_2: begin
				dis <= multiplier;
				a <= y-central[19:16];
				state <= get_dis1_3;
			end
			get_dis1_3: begin
				dis <= dis + multiplier;
				a <= radius[11:8];
				state <= get_dis1;
			end
			get_dis1: begin
				if(dis <= multiplier) d_r1 <= 0;
				else d_r1 <= 1;
				
				a <= x-central[15:12];
				state <= get_dis2_1;
			end
			get_dis2_1: begin
				dis <= multiplier;
				a <= y-central[11:8];
				state <= get_dis2_2;
			end
			get_dis2_2: begin
				dis <= dis + multiplier;
				a <= radius[7:4];
				state <= get_dis2;
			end
			get_dis2: begin
				if(dis <= multiplier) d_r2 <= 0;
				else d_r2 <= 1;
				
				a <= x-central[7:4];
				state <= get_dis3_1;
			end
			get_dis3_1: begin
				dis <= multiplier;
				a <= y-central[3:0];
				state <= get_dis3_2;
			end
			get_dis3_2: begin
				dis <= dis + multiplier;
				a <= radius[3:0];
				state <= get_dis3;
			end
			get_dis3: begin
				if(dis <= multiplier) d_r3 <= 0;
				else d_r3 <= 1;
				
				state <= decide_candidate;
			end
			decide_candidate: begin
				case(mode)
					2'b00: begin
						if(!d_r1) candidate <= candidate + 8'd1;
						else candidate <= candidate;
					end
					2'b01: begin
						if(!d_r1&&!d_r2) candidate <= candidate + 8'd1;
						else candidate <= candidate;
					end
					2'b10: begin
						if((!d_r1&&d_r2)||(d_r1&&!d_r2)) candidate <= candidate + 8'd1;
						else candidate <= candidate;
					end
					2'b11: begin
						if((!d_r1&&!d_r2&&d_r3)||(!d_r1&&d_r2&&!d_r3)||(d_r1&&!d_r2&&!d_r3)) candidate <= candidate + 8'd1;
						else candidate <= candidate;
					end
				endcase
				state <= counter;
			end
			counter: begin
				if(x==4'd8&&y==4'd8) begin
					busy <= 0;
					valid <= 1;
					state <= initialization;
				end
				else if(x!=4'd8) begin
					x <= x+4'd1;
					state <= get_dis1_1;
				end
				else begin
					x <= 4'd1;
					y <= y+4'd1;
					state <= get_dis1_1;
				end
			end
		endcase
	end
end

endmodule