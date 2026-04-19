typedef enum logic [3:0] {
  LV1=1, LV2=2, LV3=3, LV4=4, LV5=5, LV6=6, LV7=7, LV8=8, MOVING_UP=9, MOVING_DOWN = 10, DOOR_OPEN=11, DOOR_CLOSED=12, IDLE=13, ERROR=14
} state_t;

module elevator_fsm (
    input logic clk,
    input logic rst,
    input logic [2:0] next_floor,
    input logic door_open_req,
    input logic door_close_req,
    input logic [2:0] curr_floor,
    input logic door_open,
    input logic moving,

    output state_t state
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
                else if(curr_floor == next_floor) n_state = IDLE;
            LV1: n_state = (door_open_req) ? DOOR_OPEN : LV1;
            LV2: n_state = (door_open_req) ? DOOR_OPEN : LV2;
            LV3: n_state = (door_open_req) ? DOOR_OPEN : LV3;
            LV4: n_state = (door_open_req) ? DOOR_OPEN : LV4;
            LV5: n_state = (door_open_req) ? DOOR_OPEN : LV5;
            LV6: n_state = (door_open_req) ? DOOR_OPEN : LV6;
            LV7: n_state = (door_open_req) ? DOOR_OPEN : LV7;
            LV8: n_state = (door_open_req) ? DOOR_OPEN : LV8;
            MOVING_UP: n_state = (curr_floor == next_floor) ? IDLE : MOVING_UP;
            MOVING_DOWN: n_state = (curr_floor == next_floor) ? IDLE : MOVING_DOWN;
            DOOR_OPEN: n_state = (door_close_req) ? DOOR_CLOSED : DOOR_OPEN;
            DOOR_CLOSED: n_state = (door_open_req) ? DOOR_OPEN : DOOR_CLOSED;
            default: n_state = ERROR;
        endcase;
    end
    
endmodule 

// test comment
