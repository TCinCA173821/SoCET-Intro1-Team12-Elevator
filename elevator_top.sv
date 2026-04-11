module elevator_top (
	input logic clk,
	input logic rst_n,

	input logic [4:0] inside_btn,  //floors 
	input logic btn_open,
	input logic btn_close,

	input logic [3:0] call_btn_up,
	input logic [3:0] call_btn_down,

//outputs

	output logic [6:0] seg, //a 7 segments display (easiest to display #s)
	output logic led_up, //shows dir. up
	output logic led_down, //shows dir. down
	output logic led_door //door open indicator
);

// internal wires, no data being processed here
// we need to know the current floor and the next floor to control the outputs and the fsm, we also need to know if the door is open or not, if there is a request to open or close the door, if the elevator is moving, and if it is going up or down
// curr_floor and next_floor are 3 wires because they can represent 0-7 in binary instead of doing 5 seperate wires (one per floor)

	logic [2:0] curr_floor;
	logic [2:0] next_floor;
	logic door_open; // door status
	logic door_open_req;
	logic door_close_req;
	logic moving; //if elevator is in motion we need to control certain outputs
	logic dir_up; //no need for dir_down, this tells us if motion is downwards too

// floor controller
// i hate homework
	floor_controller u_ctrl (
		.clk (clk),
		.rst_n (rst_n),
		.inside_btn (inside_btn),
		.call_btn_up (call_btn_up),
		.call_btn_down (call_btn_down),
		.btn_open (btn_open),
		.btn_close (btn_close),
		.curr_floor (curr_floor),
		.door_open (door_open),
		.moving (moving),

		//outputting 
		.next_floor (next_floor),
		.door_open_req (door_open_req),
		.door_close_req (door_close_req),
	);

	elevator_fsm u_fsm (
		.clk           (clk),
        .rst_n         (rst_n),
        .next_floor    (next_floor),
        .door_open_req (door_open_req),
        .door_close_req(door_close_req),
        .curr_floor    (curr_floor),
        .door_open     (door_open),
        .moving        (moving),
        .dir_up        (dir_up)
    );
 
    //display
    display u_disp (
        .curr_floor (curr_floor),
        .dir_up     (dir_up),
        .moving     (moving),
        .door_open  (door_open),
        .seg        (seg),
        .led_up     (led_up),
        .led_down   (led_down),
        .led_door   (led_door)
    );
 
endmodule 
		

