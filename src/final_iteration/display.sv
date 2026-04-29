module display_decoder (
  input logic [2:0] current_floor,
  input logic [2:0] floor_req,
  output logic red,
  output logic green,
  output logic blue,
  output logic [7:0] ss0
);

  localparam [2:0] S1 = 3'd1;
  localparam [2:0] S2 = 3'd2;
  localparam [2:0] S3 = 3'd3;
  localparam [2:0] S4 = 3'd4;
  localparam [2:0] S5 = 3'd5;

  always_comb begin
    red = 1'b0;
    green = 1'b0;
    blue = 1'b0;
    ss0 = 8'b00000000;

    if (floor_req > current_floor)
      blue = 1'b1;
    else if (floor_req < current_floor)
      red = 1'b1;
    else
      green = 1'b1;

    case (current_floor)
      S1: ss0 = 8'b00000110;
      S2: ss0 = 8'b01011011;
      S3: ss0 = 8'b01001111;
      S4: ss0 = 8'b01100110;
      S5: ss0 = 8'b01101101;
      default: ss0 = 8'b00000000;
    endcase
  end

endmodule