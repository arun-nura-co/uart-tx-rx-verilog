module uart_top(
    input clk,
    input reset,
    input start,
    input [7:0] user_data,
    output tx,
    output [7:0] received_data,
    output valid
);

wire tx_line;

uart_tx tx_unit(
    .clk(clk),
    .reset(reset),
    .start(start),
    .data_in(user_data),
    .tx(tx_line),
    .busy()
);

uart_rx rx_unit(
    .clk(clk),
    .reset(reset),
    .rx(tx_line),
    .data_out(received_data),
    .data_valid(valid)
);

assign tx = tx_line;

endmodule