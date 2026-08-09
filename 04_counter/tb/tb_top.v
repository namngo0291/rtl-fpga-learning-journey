`timescale 1ns/1ps

module tb_top;

reg clk_50m_n18;
reg rst_n_key1;
reg dir_key2_n;
reg pause_key3_n;

wire led1;
wire led2;
wire led3;

wire tick_1hz;
wire count_down;
wire counter_enable;
wire [2:0] count;

assign tick_1hz      = uut.tick_1hz;
assign count_down    = uut.count_down;
assign counter_enable = uut.counter_enable;
assign count         = uut.count;

top #(
    .CLK_FREQ_HZ(20),
    .LED_ACTIVE_LOW(0)
) uut (
    .clk_50m_n18(clk_50m_n18),
    .rst_n_key1(rst_n_key1),
    .dir_key2_n(dir_key2_n),
    .pause_key3_n(pause_key3_n),
    .led1(led1),
    .led2(led2),
    .led3(led3)
);

initial begin
    clk_50m_n18 = 1'b0;
    forever #5 clk_50m_n18 = ~clk_50m_n18;
end

initial begin
    rst_n_key1  = 1'b0;
    dir_key2_n  = 1'b1;
    pause_key3_n = 1'b1;

    #50;
    rst_n_key1 = 1'b1;

    // Count up
    #1000;

    // Hold KEY2: count down
    dir_key2_n = 1'b0;
    #1000;

    // Press KEY3: pause counter
    pause_key3_n = 1'b0;
    #500;

    // Release KEY3: resume counter
    pause_key3_n = 1'b1;
    #800;

    // Release KEY2: count up again
    dir_key2_n = 1'b1;
    #1000;

    // Reset again
    rst_n_key1 = 1'b0;
    #100;

    rst_n_key1 = 1'b1;
    #500;

    $finish;
end

endmodule
