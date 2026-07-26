module top #(
    parameter integer CLK_FREQ_HZ = 50_000_000
)(
    input  wire clk_50m_n18,
    input  wire rst_n_key1,
    output wire led1,
    output wire led2,
    output wire led3
);

led_blink #(
    .TOGGLE_COUNT(CLK_FREQ_HZ / 2),
    .LED_ACTIVE_LOW(0)
) u_led1 (
    .clk(clk_50m_n18),
    .rst_n(rst_n_key1),
    .led(led1)
);

led_blink #(
    .TOGGLE_COUNT(CLK_FREQ_HZ / 4),
    .LED_ACTIVE_LOW(0)
) u_led2 (
    .clk(clk_50m_n18),
    .rst_n(rst_n_key1),
    .led(led2)
);

led_blink #(
    .TOGGLE_COUNT(CLK_FREQ_HZ),
    .LED_ACTIVE_LOW(0)
) u_led3 (
    .clk(clk_50m_n18),
    .rst_n(rst_n_key1),
    .led(led3)
);

endmodule
