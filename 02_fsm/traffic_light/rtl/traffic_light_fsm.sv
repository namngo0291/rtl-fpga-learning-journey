module traffic_light_fsm (
    input  logic clk,
    input  logic rst_n,
    input  logic enable,

    output logic red,
    output logic yellow,
    output logic green
);

    typedef enum logic [1:0] {
        RED    = 2'b00,
        GREEN  = 2'b01,
        YELLOW = 2'b10
    } state_t;

    state_t state;
    state_t next_state;

    // =====================================================
    // State Register
    // =====================================================
    always_ff @(posedge clk) begin
        if (!rst_n)
            state <= RED;
        else
            state <= next_state;
    end

    // =====================================================
    // Next-State Logic
    // =====================================================
    always_comb begin

        next_state = state;

        case (state)

            RED: begin
                if (enable)
                    next_state = GREEN;
            end

            GREEN: begin
                if (enable)
                    next_state = YELLOW;
            end

            YELLOW: begin
                if (enable)
                    next_state = RED;
            end

            default: begin
                next_state = RED;
            end

        endcase

    end

    // =====================================================
    // Moore Output Logic
    // =====================================================
    always_comb begin

        red    = 1'b0;
        yellow = 1'b0;
        green  = 1'b0;

        case (state)

            RED:
                red = 1'b1;

            GREEN:
                green = 1'b1;

            YELLOW:
                yellow = 1'b1;

            default:
                red = 1'b1;

        endcase

    end

endmodule
