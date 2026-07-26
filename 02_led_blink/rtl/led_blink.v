module led_blink #(
    parameter integer TOGGLE_COUNT   = 25_000_000,
    parameter integer LED_ACTIVE_LOW = 0
)(
    input  wire clk,
    input  wire rst_n,
    output wire led
);

localparam integer CNT_WIDTH = (TOGGLE_COUNT <= 1) ? 1 : $clog2(TOGGLE_COUNT);

reg [CNT_WIDTH-1:0] counter;
reg led_state;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter   <= 0;
        led_state <= 1'b0;
    end else begin
        if (counter == TOGGLE_COUNT - 1) begin
            counter   <= 0;
            led_state <= ~led_state;
        end else begin
            counter <= counter + 1'b1;
        end
    end
end

assign led = LED_ACTIVE_LOW ? ~led_state : led_state;

endmodule
