`timescale 1ns/1ps

module tb_top_traffic_light;

    localparam int CLK_FREQ_HZ = 4;

    logic clk;
    logic rst_n;

    logic led_red;
    logic led_yellow;
    logic led_green;

    int error_count;

    // ------------------------------------------------------------
    // DUT
    // ------------------------------------------------------------
    top_traffic_light #(
        .CLK_FREQ_HZ(CLK_FREQ_HZ)
    ) dut (
        .clk_50m    (clk),
        .rst_n      (rst_n),
        .led_red    (led_red),
        .led_yellow (led_yellow),
        .led_green  (led_green)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    // ------------------------------------------------------------
    // Check LED outputs
    // ------------------------------------------------------------
    task automatic check_leds(
        input logic expected_red,
        input logic expected_yellow,
        input logic expected_green,
        input string state_name
    );
        begin
            if ({led_red, led_yellow, led_green} !==
                {expected_red, expected_yellow, expected_green}) begin

                $display(
                    "ERROR: Expected %s = %b%b%b, got %b%b%b at time %0t ns",
                    state_name,
                    expected_red,
                    expected_yellow,
                    expected_green,
                    led_red,
                    led_yellow,
                    led_green,
                    $time
                );

                error_count++;
            end
            else begin
                $display(
                    "PASS: %s = %b%b%b at time %0t ns",
                    state_name,
                    led_red,
                    led_yellow,
                    led_green,
                    $time
                );
            end
        end
    endtask

    // ------------------------------------------------------------
    // Wait for clock-enable pulse, then wait one clock edge
    // so the FSM can consume tick_1hz.
    // ------------------------------------------------------------
    task automatic wait_for_tick_and_check(
        input logic expected_red,
        input logic expected_yellow,
        input logic expected_green,
        input string state_name
    );
        begin
            @(posedge dut.tick_1hz);
            @(posedge clk);
            #1;

            check_leds(
                expected_red,
                expected_yellow,
                expected_green,
                state_name
            );
        end
    endtask

    // ------------------------------------------------------------
    // Test sequence
    // ------------------------------------------------------------
    initial begin

        clk = 1'b0;
        rst_n = 1'b0;
        error_count = 0;

        $dumpfile("traffic_light_fpga.vcd");
        $dumpvars(0, tb_top_traffic_light);

        // --------------------------------------------------------
        // Reset
        // --------------------------------------------------------
        repeat (2) @(posedge clk);
        #1;

        check_leds(
            1'b1,
            1'b0,
            1'b0,
            "RED after reset"
        );

        // Release reset
        rst_n = 1'b1;

        // --------------------------------------------------------
        // RED -> GREEN
        // --------------------------------------------------------
        wait_for_tick_and_check(
            1'b0,
            1'b0,
            1'b1,
            "GREEN"
        );

        // --------------------------------------------------------
        // GREEN -> YELLOW
        // --------------------------------------------------------
        wait_for_tick_and_check(
            1'b0,
            1'b1,
            1'b0,
            "YELLOW"
        );

        // --------------------------------------------------------
        // YELLOW -> RED
        // --------------------------------------------------------
        wait_for_tick_and_check(
            1'b1,
            1'b0,
            1'b0,
            "RED"
        );

        // --------------------------------------------------------
        // Final result
        // --------------------------------------------------------
        if (error_count == 0) begin
            $display("");
            $display("==============================================");
            $display("ALL TESTS PASSED!");
            $display("Traffic Light FPGA Wrapper is working correctly.");
            $display("==============================================");
        end
        else begin
            $display("");
            $display("==============================================");
            $display("TEST FAILED!");
            $display("Error count = %0d", error_count);
            $display("==============================================");
        end

        $finish;
    end

endmodule
