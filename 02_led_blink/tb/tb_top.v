`timescale 1ns/1ps

module tb_top;

reg clk_50m_n18;
reg rst_n_key1;

wire led1;
wire led2;
wire led3;

top #(
    .CLK_FREQ_HZ(100)
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
    #1500;

    rst_n_key1 = 1'b0;
    #100;

    rst_n_key1 = 1'b1;
    #1500;

    $finish;
end

endmodule
