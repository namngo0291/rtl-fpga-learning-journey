`timescale 1ns/1ps

module tb_traffic_light_fsm;

    // =========================================================
    // Testbench signals
    // =========================================================
    logic clk;
    logic rst_n;
    logic enable;

    logic red;
    logic yellow;
    logic green;

    int error_count;

    // =========================================================
    // Device Under Test
    // =========================================================
    traffic_light_fsm dut (
        .clk    (clk),
        .rst_n  (rst_n),
        .enable (enable),
        .red    (red),
        .yellow (yellow),
        .green  (green)
    );

    // =========================================================
    // Clock generation
    //
    // Clock period = 10 ns
    // Frequency    = 100 MHz
    // =========================================================
    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end

    // =========================================================
    // VCD waveform
    // =========================================================
    initial begin
        $dumpfile("traffic_light_fsm.vcd");
        $dumpvars(0, tb_traffic_light_fsm);
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
        $display("     TRAFFIC LIGHT FSM TESTBENCH");
        $display("========================================");
        $display("Clock period = 10 ns");
        $display("");

        // =====================================================
        // TEST 1
        // Reset -> RED
        // =====================================================
        $display("----------------------------------------");
        $display("TEST 1: Reset -> RED");
        $display("----------------------------------------");

        @(posedge clk);
        #1;

        if (red !== 1'b1 ||
            yellow !== 1'b0 ||
            green !== 1'b0) begin

            $error(
                "FAIL: Reset did not produce RED. " +
                "red=%b yellow=%b green=%b",
                red, yellow, green
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: Reset correctly set FSM to RED."
            );
        end

        // =====================================================
        // TEST 2
        // RED -> GREEN
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 2: RED -> GREEN");
        $display("----------------------------------------");

        rst_n  = 1'b1;
        enable = 1'b1;

        @(posedge clk);
        #1;

        if (red !== 1'b0 ||
            yellow !== 1'b0 ||
            green !== 1'b1) begin

            $error(
                "FAIL: RED did not transition to GREEN. " +
                "red=%b yellow=%b green=%b",
                red, yellow, green
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: RED -> GREEN"
            );
        end

        // =====================================================
        // TEST 3
        // GREEN -> YELLOW
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 3: GREEN -> YELLOW");
        $display("----------------------------------------");

        @(posedge clk);
        #1;

        if (red !== 1'b0 ||
            yellow !== 1'b1 ||
            green !== 1'b0) begin

            $error(
                "FAIL: GREEN did not transition to YELLOW. " +
                "red=%b yellow=%b green=%b",
                red, yellow, green
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: GREEN -> YELLOW"
            );
        end

        // =====================================================
        // TEST 4
        // YELLOW -> RED
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 4: YELLOW -> RED");
        $display("----------------------------------------");

        @(posedge clk);
        #1;

        if (red !== 1'b1 ||
            yellow !== 1'b0 ||
            green !== 1'b0) begin

            $error(
                "FAIL: YELLOW did not transition to RED. " +
                "red=%b yellow=%b green=%b",
                red, yellow, green
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: YELLOW -> RED"
            );
        end

        // =====================================================
        // TEST 5
        // HOLD RED when enable = 0
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 5: HOLD RED with enable = 0");
        $display("----------------------------------------");

        enable = 1'b0;

        @(posedge clk);
        #1;

        if (red !== 1'b1 ||
            yellow !== 1'b0 ||
            green !== 1'b0) begin

            $error(
                "FAIL: RED did not hold when enable=0. " +
                "red=%b yellow=%b green=%b",
                red, yellow, green
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: RED held with enable=0."
            );
        end

        // Check again
        @(posedge clk);
        #1;

        if (red !== 1'b1 ||
            yellow !== 1'b0 ||
            green !== 1'b0) begin

            $error(
                "FAIL: RED changed while enable=0. " +
                "red=%b yellow=%b green=%b",
                red, yellow, green
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: RED still held."
            );
        end

        // =====================================================
        // TEST 6
        // GREEN -> HOLD GREEN
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 6: HOLD GREEN with enable = 0");
        $display("----------------------------------------");

        // First move RED -> GREEN
        enable = 1'b1;

        @(posedge clk);
        #1;

        if (green !== 1'b1) begin
            $error(
                "FAIL: Could not return to GREEN."
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: RED -> GREEN."
            );
        end

        // Disable FSM
        enable = 1'b0;

        @(posedge clk);
        #1;

        if (red !== 1'b0 ||
            yellow !== 1'b0 ||
            green !== 1'b1) begin

            $error(
                "FAIL: GREEN did not hold with enable=0. " +
                "red=%b yellow=%b green=%b",
                red, yellow, green
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: GREEN held with enable=0."
            );
        end

        // =====================================================
        // TEST 7
        // Complete FSM cycle
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 7: Complete FSM cycle");
        $display("----------------------------------------");

        enable = 1'b1;

        // GREEN -> YELLOW
        @(posedge clk);
        #1;

        if (yellow !== 1'b1) begin
            $error(
                "FAIL: GREEN -> YELLOW."
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: GREEN -> YELLOW."
            );
        end

        // YELLOW -> RED
        @(posedge clk);
        #1;

        if (red !== 1'b1) begin
            $error(
                "FAIL: YELLOW -> RED."
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: YELLOW -> RED."
            );
        end

        // RED -> GREEN
        @(posedge clk);
        #1;

        if (green !== 1'b1) begin
            $error(
                "FAIL: RED -> GREEN."
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: RED -> GREEN."
            );
        end

        // =====================================================
        // TEST 8
        // One-hot output check
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 8: One-hot traffic light output");
        $display("----------------------------------------");

        // Current state should be GREEN
        if ((red + yellow + green) != 1) begin

            $error(
                "FAIL: More than one or no traffic light is active. " +
                "red=%b yellow=%b green=%b",
                red, yellow, green
            );

            error_count++;
        end
        else begin
            $display(
                "PASS: Exactly one traffic light is active."
            );
        end

        // =====================================================
        // TEST 9
        // Repeat cycle several times
        // =====================================================
        $display("");
        $display("----------------------------------------");
        $display("TEST 9: Repeated FSM operation");
        $display("----------------------------------------");

        repeat (6) begin

            @(posedge clk);
            #1;

            if ((red + yellow + green) != 1) begin

                $error(
                    "FAIL: Invalid output combination. " +
                    "red=%b yellow=%b green=%b",
                    red, yellow, green
                );

                error_count++;
            end

        end

        if (error_count == 0)
            $display("PASS: FSM operated correctly for multiple cycles.");
        else
            $display("FSM errors detected during repeated operation.");

        // =====================================================
        // TEST SUMMARY
        // =====================================================
        $display("");
        $display("========================================");
        $display("           TEST SUMMARY");
        $display("========================================");

        if (error_count == 0) begin
            $display("ALL TESTS PASSED!");
            $display("Traffic Light FSM is working correctly.");
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
