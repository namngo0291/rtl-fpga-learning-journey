module counter_3bit (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       enable,
    input  wire       count_down,
    output reg  [2:0] count
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 3'b000;
    end else begin
        if (enable) begin
            if (count_down)
                count <= count - 1'b1;
            else
                count <= count + 1'b1;
        end
    end
end

endmodule
