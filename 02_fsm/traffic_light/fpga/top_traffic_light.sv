module top_traffic_light #(
    parameter int unsigned CLK_FREQ_HZ = 50_000_000
) (
    input  logic clk_50m,
    input  logic rst_n,
    output logic led_red,
    output logic led_yellow,
    output logic led_green
);

    logic tick_1hz;

    // Generate a one-clock-cycle enable pulse.
    // For FPGA operation:
    // CLK_FREQ_HZ = 50_000_000
    //
    // For simulation:
    // CLK_FREQ_HZ can be reduced, e.g. 4.

    clock_enable_1hz #(
        .CLK_FREQ_HZ(CLK_FREQ_HZ)
    ) u_clock_enable (
        .clk      (clk_50m),
        .rst_n    (rst_n),
        .tick_1hz (tick_1hz)
    );

    traffic_light_fsm u_traffic_light_fsm (
        .clk    (clk_50m),
        .rst_n  (rst_n),
        .enable (tick_1hz),
        .red    (led_red),
        .yellow (led_yellow),
        .green  (led_green)
    );

endmodule
