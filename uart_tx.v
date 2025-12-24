`timescale 1ns / 1ps

module uart_tx(
    input wire clk,
    input wire reset,
    input wire tx_start,
    input wire [7:0]tx_data,
    output reg tx,
    output reg tx_busy);
wire baud_pulse;
baud_gen inst1(.clk(clk),.reset(reset),.baud_pulse(baud_pulse));
localparam idle = 2'b00;
localparam start = 2'b01;
localparam data = 2'b10;
localparam stop = 2'b11;
reg [1:0]current_state;
reg [7:0]shift_reg;
reg [2:0]bit_cnt;
reg tx_req; 
always @(posedge clk) begin
if (reset) begin
current_state <= idle;
tx <= 1'b1;            
tx_busy <= 1'b0;
shift_reg <= 8'b0;
bit_cnt <= 3'b0;
tx_req <= 1'b0;
end
else begin
if (tx_start)
tx_req <= 1'b1;
if (baud_pulse) begin
case (current_state)
2'b00: begin
tx <= 1'b1;
tx_busy <= 1'b0;
bit_cnt <= 3'b0;
if (tx_req) begin
shift_reg <= tx_data;
tx_req <= 1'b0;
tx_busy <= 1'b1;
current_state <= start;                        
end
end
2'b01: begin
tx <= 1'b0;
current_state <= data;
end
2'b10: begin
tx <= shift_reg[0];                        
shift_reg <= shift_reg >> 1;
if (bit_cnt==3'd7) begin
bit_cnt <= 3'b0;
current_state <= stop;
end                         
else begin
bit_cnt <= bit_cnt + 1;
end
end
2'b11: begin
tx <= 1'b1; 
current_state <= idle;
end
default: current_state <= idle;
endcase
end
end
end
endmodule