module top #(
    parameter integer CLK_FREQ_HZ    = 50_000_000,
    parameter integer LED_ACTIVE_LOW = 0
)(
    input  wire clk_50m_n18,
    input  wire rst_n_key1,
    input  wire dir_key2_n,
    input  wire pause_key3_n,
    output wire led1,
    output wire led2,
    output wire led3
);

wire tick_1hz;
wire count_down;
wire counter_enable;

wire [2:0] count;

assign count_down     = ~dir_key2_n;
assign counter_enable = tick_1hz & pause_key3_n;

clock_enable #(
    .DIV_COUNT(CLK_FREQ_HZ)
) u_clock_enable_1hz (
    .clk(clk_50m_n18),
    .rst_n(rst_n_key1),
    .enable_pulse(tick_1hz)
);

counter_3bit u_counter_3bit (
    .clk(clk_50m_n18),
    .rst_n(rst_n_key1),
    .enable(counter_enable),
    .count_down(count_down),
    .count(count)
);

assign led1 = LED_ACTIVE_LOW ? ~count[0] : count[0];
assign led2 = LED_ACTIVE_LOW ? ~count[1] : count[1];
assign led3 = LED_ACTIVE_LOW ? ~count[2] : count[2];

endmodule
