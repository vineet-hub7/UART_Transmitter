`timescale 1ns / 1ps

module baud_gen(
    input wire clk,
    input wire reset,
    output reg baud_pulse);
parameter integer clock_freq = 100_000_000;
parameter integer baud_rate = 9600;
localparam integer divider = clock_freq / baud_rate;
integer cnt;
always @(posedge clk) begin
if (reset) begin
cnt <= 0;
baud_pulse <= 0;
end 
else begin
if (cnt==divider-1) begin
cnt <= 0;
baud_pulse <= 1;
end 
else begin
cnt <= cnt + 1;
baud_pulse <= 0;           
end
end
end
endmodule