`default_nettype none

module top (
  input  logic hz100, reset,
  input  logic [19:0] pb,
  output logic [7:0] left, right, ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);

  logic [2:0] floor_req;
  logic [2:0] current_floor;

  logic clk50;
  logic one_sec_tick;
  logic moving;

  assign moving = (current_floor != floor_req);

  button_decoder u_button_decoder (
    .clk (hz100),
    .reset (reset),
    .pb (pb[5:1]),
    .floor_req (floor_req)
  );

  clock_timer u_clock_timer (
    .clk (hz100),
    .reset (reset),
    .enable (moving),
    .clk_div2 (clk50),
    .one_sec_tick (one_sec_tick)
  );

  elevator_fsm u_elevator_fsm (
    .clk (hz100),
    .reset (reset),
    .floor_req (floor_req),
    .one_sec_tick (one_sec_tick),
    .current_floor (current_floor)
  );

  display_decoder u_display_decoder (
    .current_floor (current_floor),
    .floor_req (floor_req),
    .red (red),
    .green (green),
    .blue (blue),
    .ss0 (ss0)
  );

  assign left = 8'b00000000;
  assign right = 8'b00000000;

  assign ss7 = 8'b00000000;
  assign ss6 = 8'b00000000;
  assign ss5 = 8'b00000000;
  assign ss4 = 8'b00000000;
  assign ss3 = 8'b00000000;
  assign ss2 = 8'b00000000;
  assign ss1 = 8'b00000000;

  assign txdata = 8'b00000000;

  assign txclk = clk50;
  assign rxclk = clk50;

endmodule