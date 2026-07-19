`timescale 1ns/1ps

module tb_counter_4bit;

reg clk;
reg rst_n;
wire [3:0] count;

counter_4bit uut (
    .clk(clk),
    .rst_n(rst_n),
    .count(count)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 0;
    #20 rst_n = 1;
    #200 $finish;
end

endmodule
