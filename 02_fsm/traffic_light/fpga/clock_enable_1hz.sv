module clock_enable_1hz #(
    parameter int unsigned CLK_FREQ_HZ = 50_000_000
) (
    input  logic clk,
    input  logic rst_n,
    output logic tick_1hz
);

    localparam int unsigned COUNTER_WIDTH = $clog2(CLK_FREQ_HZ);

    logic [COUNTER_WIDTH-1:0] counter;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            counter  <= '0;
            tick_1hz <= 1'b0;
        end
        else if (counter == CLK_FREQ_HZ - 1) begin
            counter  <= '0;
            tick_1hz <= 1'b1;
        end
        else begin
            counter  <= counter + 1'b1;
            tick_1hz <= 1'b0;
        end
    end

endmodule
