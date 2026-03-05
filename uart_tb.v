`timescale 1ns/1ps

module uart_tb;

reg clk = 0;
reg reset = 1;
reg start = 0;
reg [7:0] data;

wire tx;
wire [7:0] received_data;
wire valid;

uart_top uut(
    .clk(clk),
    .reset(reset),
    .start(start),
    .user_data(data),
    .tx(tx),
    .received_data(received_data),
    .valid(valid)
);

always #5 clk = ~clk;

initial
begin
    #100 reset = 0;

    data = 8'b01010101;
    #100 start = 1;
    #10 start = 0;
    
    #20000000 
    $stop;
end

endmodule