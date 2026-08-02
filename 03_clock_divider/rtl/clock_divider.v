module clock_enable #(
    parameter integer DIV_COUNT = 50_000_000
)(
    input  wire clk,
    input  wire rst_n,
    output reg  enable_pulse
);

localparam integer CNT_WIDTH = (DIV_COUNT <= 1) ? 1 : $clog2(DIV_COUNT);

reg [CNT_WIDTH-1:0] counter;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter      <= 0;
        enable_pulse <= 1'b0;
    end else begin
        if (counter == DIV_COUNT - 1) begin
            counter      <= 0;
            enable_pulse <= 1'b1;
        end else begin
            counter      <= counter + 1'b1;
            enable_pulse <= 1'b0;
        end
    end
end

endmodule
