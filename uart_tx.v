module uart_tx #(
    parameter CLK_FREQ = 100000000,   // 100 MHz clock
    parameter BAUD_RATE = 115200
)(
    input clk,
    input reset,
    input start,
    input [7:0] data_in,
    output reg tx,
    output reg busy
);

localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

reg [13:0] clk_count = 0;
reg [3:0] bit_index = 0;
reg [9:0] tx_data;
reg transmitting = 0;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        tx <= 1'b1;
        busy <= 0;
        transmitting <= 0;
        clk_count <= 0;
        bit_index <= 0;
    end
    else
    begin
        if(start && !transmitting)
        begin
            tx_data <= {1'b1, data_in, 1'b0}; // stop + data + start
            transmitting <= 1;
            busy <= 1;
            bit_index <= 0;
            clk_count <= 0;
        end

        if(transmitting)
        begin
            if(clk_count < CLKS_PER_BIT-1)
                clk_count <= clk_count + 1;
            else
            begin
                clk_count <= 0;
                tx <= tx_data[bit_index];
                bit_index <= bit_index + 1;

                if(bit_index == 9)
                begin
                    transmitting <= 0;
                    busy <= 0;
                    tx <= 1'b1;
                end
            end
        end
    end
end

endmodule