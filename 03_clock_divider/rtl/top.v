module top #(
    parameter integer CLK_FREQ_HZ    = 50_000_000,
    parameter integer LED_ACTIVE_LOW = 0
)(
    input  wire clk_50m_n18,
    input  wire rst_n_key1,
    output wire led1,
    output wire led2,
    output wire led3
);

wire en_1hz;
wire en_2hz;
wire en_0p5hz;

reg led1_state;
reg led2_state;
reg led3_state;

clock_enable #(
    .DIV_COUNT(CLK_FREQ_HZ)
) u_clock_enable_1hz (
    .clk(clk_50m_n18),
    .rst_n(rst_n_key1),
    .enable_pulse(en_1hz)
);

clock_enable #(
    .DIV_COUNT(CLK_FREQ_HZ / 2)
) u_clock_enable_2hz (
    .clk(clk_50m_n18),
    .rst_n(rst_n_key1),
    .enable_pulse(en_2hz)
);

clock_enable #(
    .DIV_COUNT(CLK_FREQ_HZ * 2)
) u_clock_enable_0p5hz (
    .clk(clk_50m_n18),
    .rst_n(rst_n_key1),
    .enable_pulse(en_0p5hz)
);

always @(posedge clk_50m_n18 or negedge rst_n_key1) begin
    if (!rst_n_key1) begin
        led1_state <= 1'b0;
        led2_state <= 1'b0;
        led3_state <= 1'b0;
    end else begin
        if (en_1hz)
            led1_state <= ~led1_state;

        if (en_2hz)
            led2_state <= ~led2_state;

        if (en_0p5hz)
            led3_state <= ~led3_state;
    end
end

assign led1 = LED_ACTIVE_LOW ? ~led1_state : led1_state;
assign led2 = LED_ACTIVE_LOW ? ~led2_state : led2_state;
assign led3 = LED_ACTIVE_LOW ? ~led3_state : led3_state;

endmodule
