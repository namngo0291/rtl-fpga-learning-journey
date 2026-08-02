`timescale 1ns/1ps

module tb_top;

reg clk_50m_n18;
reg rst_n_key1;

wire led1;
wire led2;
wire led3;

wire en_1hz;
wire en_2hz;
wire en_0p5hz;

assign en_1hz   = uut.en_1hz;
assign en_2hz   = uut.en_2hz;
assign en_0p5hz = uut.en_0p5hz;

top #(
    .CLK_FREQ_HZ(20),
    .LED_ACTIVE_LOW(0)
) uut (
    .clk_50m_n18(clk_50m_n18),
    .rst_n_key1(rst_n_key1),
    .led1(led1),
    .led2(led2),
    .led3(led3)
);

initial begin
    clk_50m_n18 = 1'b0;
    forever #5 clk_50m_n18 = ~clk_50m_n18;
end

initial begin
    rst_n_key1 = 1'b0;
    #50;

    rst_n_key1 = 1'b1;
    #1000;

    rst_n_key1 = 1'b0;
    #100;

    rst_n_key1 = 1'b1;
    #1000;

    $finish;
end

endmodule
