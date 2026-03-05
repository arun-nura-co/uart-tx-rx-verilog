module uart_rx #(
    parameter CLK_FREQ = 100000000,
    parameter BAUD_RATE = 115200
)(
    input clk,
    input reset,
    input rx,
    output reg [7:0] data_out,
    output reg data_valid
);

localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

// Synchronize asynchronous RX input
reg rx_sync1 = 1;
reg rx_sync2 = 1;

always @(posedge clk)
begin
    rx_sync1 <= rx;
    rx_sync2 <= rx_sync1;
end

// Receiver registers
reg [13:0] clk_count = 0;
reg [3:0] bit_index = 0;
reg [7:0] rx_shift = 0;
reg receiving = 0;

// Previous RX state for edge detection
reg rx_prev = 1;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        clk_count <= 0;
        bit_index <= 0;
        receiving <= 0;
        data_valid <= 0;
        data_out <= 0;
        rx_prev <= 1;
    end
    else
    begin
        data_valid <= 0;

        // store previous RX state
        rx_prev <= rx_sync2;

        // Detect falling edge (start bit)
        if(!receiving && rx_prev == 1 && rx_sync2 == 0)
        begin
            receiving <= 1;
            clk_count <= CLKS_PER_BIT/2; // sample middle of start bit
            bit_index <= 0;
        end

        else if(receiving)
        begin
            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else
            begin
                clk_count <= 0;

                if(bit_index < 8)
                begin
                    rx_shift[7-bit_index] <= rx_sync2;
                    bit_index <= bit_index + 1;
                end
                else
                begin
                    receiving <= 0;
                    data_out <= rx_shift;
                    data_valid <= 1;
                end
            end
        end
    end
end

endmodule