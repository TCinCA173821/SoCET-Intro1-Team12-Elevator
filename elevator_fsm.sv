typedef enum logic [3:0] {
  LV1=1, LV2=2, LV3=3, LV4=4, LV5=5, LV6=6, LV7=7, LV8=8, MOVING_UP=9, MOVING_DOWN = 10, DOOR_OPEN=11, DOOR_CLOSED=12, IDLE=13, ERROR=14
} state_t;

module elevator_fsm (
    input logic clk,
    input logic rst_n,
    input logic [2:0] next_floor,
    input logic door_open_req,
    input logic door_close_req,
    input logic [2:0] curr_floor,
    input logic door_open,
    input logic moving,

    output state_t state
);

    state_t c_state, n_state;

endmodule 