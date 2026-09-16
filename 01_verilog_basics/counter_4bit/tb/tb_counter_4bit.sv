`timescale 1ns/1ps

module tb_counter_4bit;

    // =========================================================
    // Testbench configuration
    // =========================================================
    localparam int WIDTH = 4;

    // =========================================================
    // Signals
    // =========================================================
    logic             clk;
    logic             rst_n;
    logic             enable;
    logic [WIDTH-1:0] count;

    int error_count;

    // =========================================================
    // Device Under Test (DUT)
    // =========================================================
    counter_4bit #(
        .WIDTH(WIDTH)
    ) dut (
        .clk    (clk),
        .rst_n  (rst_n),
        .enable (enable),
        .count  (count)
    );

    // =========================================================
    // Clock generation
    // Clock period = 10 ns
    // =========================================================
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // =========================================================
    // VCD waveform
    // =========================================================
    initial begin
        $dumpfile("counter_4bit.vcd");
        $dumpvars(0, tb_counter_4bit);
    end

    // =========================================================
    // Main test sequence
    // =========================================================
    initial begin

        // -----------------------------------------------------
        // Initial values
        // -----------------------------------------------------
        rst_n       = 1'b0;
        enable      = 1'b0;
        error_count = 0;

        $display("");
        $display("========================================");
        $display("       COUNTER 4-BIT TESTBENCH");
        $display("========================================");
        $display("WIDTH = %0d", WIDTH);
        $display("Clock period = 10 ns");
        $display("");

        // =====================================================
        // TEST 1
        // Synchronous active-low reset
        // =====================================================
        $display("----------------------------------------");
        $display("TEST 1: Synchronous active-low reset");
        $display("----------------------------------------");

        // -----------------------------------------------------
        // Step 1:
        // rst_n = 0
        // Reset should occur at the next posedge.
        // -----------------------------------------------------
        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $error(
                "FAIL: Reset did not set count to 0. count = %0d",
                count
            );
            error_count++;
        end
        else begin
            $display("PASS: Reset set count to 0.");
        end

        // -----------------------------------------------------
        // Step 2:
        // Release reset and enable counting.
        // -----------------------------------------------------
        rst_n  = 1'b1;
        enable = 1'b1;

        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $error(
                "FAIL: Counter did not start at 1. count = %0d",
                count
            );
            error_count++;
        end
        else begin
            $display("PASS: Counter started at 1.");
        end

        // -----------------------------------------------------
        // Step 3:
        // Assert reset BETWEEN clock edges.
        //
        // Because reset is synchronous, count must remain 1
        // until the next rising edge.
        // -----------------------------------------------------
        #2;
        rst_n = 1'b0;

        #2;

        if (count !== 4'b0001) begin
            $error(
                "FAIL: Counter reset before clock edge. count = %0d",
                count
            );
            error_count++;
        end
        else begin
            $display(
                "PASS: Counter did not reset before clock edge."
            );
        end

        // -----------------------------------------------------
        // Step 4:
        // At the next posedge, synchronous reset takes effect.
        // -----------------------------------------------------
        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $error(
                "FAIL: Synchronous reset failed. count = %0d",
                count
            );
            error_count++;
        end
        else begin
            $display(
                "PASS: Synchronous reset set count to 0."
            );
        end

        // Release reset
        rst_n = 1'b1;

        // =====================================================
        // TEST 2
        // Counting when enable = 1
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 2: Counting with enable = 1");
        $display("----------------------------------------");

        enable = 1'b1;

        // Expected = 1
        @(posedge clk);
        #1;

        if (count !== 4'b0001) begin
            $error(
                "FAIL: Expected 1, got %0d",
                count
            );
            error_count++;
        end
        else begin
            $display("PASS: Count = %0d", count);
        end

        // Expected = 2
        @(posedge clk);
        #1;

        if (count !== 4'b0010) begin
            $error(
                "FAIL: Expected 2, got %0d",
                count
            );
            error_count++;
        end
        else begin
            $display("PASS: Count = %0d", count);
        end

        // Expected = 3
        @(posedge clk);
        #1;

        if (count !== 4'b0011) begin
            $error(
                "FAIL: Expected 3, got %0d",
                count
            );
            error_count++;
        end
        else begin
            $display("PASS: Count = %0d", count);
        end

        // =====================================================
        // TEST 3
        // Hold count when enable = 0
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 3: Hold count with enable = 0");
        $display("----------------------------------------");

        enable = 1'b0;

        // Count should remain 3
        @(posedge clk);
        #1;

        if (count !== 4'b0011) begin
            $error(
                "FAIL: Counter changed while enable = 0. count = %0d",
                count
            );
            error_count++;
        end
        else begin
            $display(
                "PASS: Counter held at %0d.",
                count
            );
        end

        // Check again
        @(posedge clk);
        #1;

        if (count !== 4'b0011) begin
            $error(
                "FAIL: Counter changed while enable = 0. count = %0d",
                count
            );
            error_count++;
        end
        else begin
            $display(
                "PASS: Counter still held at %0d.",
                count
            );
        end

        // =====================================================
        // TEST 4
        // Resume counting
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 4: Resume counting");
        $display("----------------------------------------");

        enable = 1'b1;

        @(posedge clk);
        #1;

        if (count !== 4'b0100) begin
            $error(
                "FAIL: Expected 4, got %0d",
                count
            );
            error_count++;
        end
        else begin
            $display(
                "PASS: Count resumed at %0d.",
                count
            );
        end

        // =====================================================
        // TEST 5
        // Overflow / wrap-around
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 5: Overflow / wrap-around");
        $display("----------------------------------------");

        // Current count = 4
        //
        // 4 -> 5 -> 6 -> ... -> 15
        //
        repeat (11) begin
            @(posedge clk);
            #1;
        end

        // Check maximum value
        if (count !== 4'b1111) begin
            $error(
                "FAIL: Expected 15 before overflow, got %0d",
                count
            );
            error_count++;
        end
        else begin
            $display(
                "PASS: Counter reached maximum value 15."
            );
        end

        // Next clock:
        // 15 -> 0
        @(posedge clk);
        #1;

        if (count !== 4'b0000) begin
            $error(
                "FAIL: Overflow failed. Expected 0, got %0d",
                count
            );
            error_count++;
        end
        else begin
            $display(
                "PASS: Overflow correctly wrapped 15 -> 0."
            );
        end

        // =====================================================
        // TEST 6
        // Parameterized WIDTH
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 6: Parameterized WIDTH");
        $display("----------------------------------------");

        if ($bits(count) != WIDTH) begin
            $error(
                "FAIL: Expected count width = %0d, got %0d",
                WIDTH,
                $bits(count)
            );
            error_count++;
        end
        else begin
            $display(
                "PASS: Counter width = %0d bits.",
                $bits(count)
            );
        end

        // =====================================================
        // TEST SUMMARY
        // =====================================================
        $display("");
        $display("========================================");
        $display("           TEST SUMMARY");
        $display("========================================");

        if (error_count == 0) begin
            $display("ALL TESTS PASSED!");
            $display("Counter design is working correctly.");
        end
        else begin
            $display("TEST FAILED!");
            $display("Total errors = %0d", error_count);
        end

        $display("========================================");
        $display("");

        $finish;

    end

endmodule
