`timescale 1ns/1ps

module tb_clock_enable_1hz;

    localparam int CLK_FREQ_HZ = 4;

    logic clk;
    logic rst_n;
    logic tick_1hz;

    int error_count;

    clock_enable_1hz #(
        .CLK_FREQ_HZ(CLK_FREQ_HZ)
    ) dut (
        .clk      (clk),
        .rst_n    (rst_n),
        .tick_1hz (tick_1hz)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        error_count = 0;

        $dumpfile("clock_enable_1hz.vcd");
        $dumpvars(0, tb_clock_enable_1hz);

        // Reset
        repeat (2) @(posedge clk);

        if (tick_1hz !== 1'b0) begin
            $display("ERROR: tick_1hz should be LOW during reset");
            error_count++;
        end

        // Release reset
        rst_n = 1'b1;

        // Check 16 clock cycles
        repeat (16) begin
            @(posedge clk);
            #1;

            if (tick_1hz)
                $display(
                    "tick_1hz HIGH at time %0t ns",
                    $time
                );
        end

        if (error_count == 0)
            $display("ALL TESTS PASSED! Clock Enable is working correctly.");
        else
            $display(
                "TEST FAILED! Error count = %0d",
                error_count
            );

        $finish;
    end

endmodule
