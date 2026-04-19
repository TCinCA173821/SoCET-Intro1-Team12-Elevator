typedef enum logic [3:0] {
    MOVING_UP=1, MOVING_DOWN = 2, DOOR_OPEN=3, DOOR_CLOSED=4, IDLE=5, ERROR=6
} state_t;

module elevator_fsm (
    input logic clk,
    input logic rst,
    input logic [2:0] next_floor,
    input logic door_open_req,
    input logic door_close_req,
    input logic [2:0] curr_floor,
    input logic moving,

    output state_t state,
    output logic motor_up,
    output logic motor_down,
    output logic door_cmd,     // 1 = open, 0 = close
    output logic [2:0] floor_display
);

    state_t c_state, n_state;
    assign state = c_state;
    

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            c_state <= IDLE;
        end else begin
            c_state <= n_state;
        end
    end

    always_comb begin 
        case(c_state)
            IDLE: if(curr_floor > next_floor) n_state = MOVING_DOWN;
                else if(curr_floor < next_floor) n_state = MOVING_UP;
                else n_state = IDLE;
            MOVING_UP: n_state = (curr_floor == next_floor) ? IDLE : MOVING_UP;
            MOVING_DOWN: n_state = (curr_floor == next_floor) ? IDLE : MOVING_DOWN;
            DOOR_OPEN: n_state = (door_close_req) ? DOOR_CLOSED : DOOR_OPEN;
            DOOR_CLOSED: n_state = (door_open_req) ? DOOR_OPEN : DOOR_CLOSED;
            default: n_state = ERROR;
        endcase;

        
    end

endmodule 

// test comment
