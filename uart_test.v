`timescale 1ns / 1ps

module uart_test;
    reg clk;
    reg reset;
    reg tx_start;
    reg [7:0]tx_data;
    wire tx;
    wire tx_busy;
uart_tx inst2(.clk(clk),.reset(reset),.tx_start(tx_start),.tx_data(tx_data),.tx(tx),.tx_busy(tx_busy));
initial begin
clk = 0;
forever #5 clk = ~clk;
end
initial begin
reset = 1;
tx_start = 0;
tx_data = 8'h00;        
#100;
reset = 0;
end
initial begin
#200;
tx_data = 8'h9F;
tx_start = 1;
@(posedge tx_busy);
tx_start = 0;
@(negedge tx_busy);
#200;
tx_data = 8'h3C;
tx_start = 1;
@(posedge tx_busy);
tx_start = 0;
@(negedge tx_busy);
end
initial begin
#6000000;
$finish;
end
endmodule