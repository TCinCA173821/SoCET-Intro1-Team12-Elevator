module elevator_fsm (
  input logic clk,
  input logic reset,
  input logic [2:0] floor_req,
  input logic one_sec_tick,
  output logic [2:0] current_floor
);

  localparam [2:0] S1 = 3'b001;
  localparam [2:0] S2 = 3'b010;
  localparam [2:0] S3 = 3'b011;
  localparam [2:0] S4 = 3'b100;
  localparam [2:0] S5 = 3'b101;

  logic [2:0] next_floor;

  always_comb begin
    next_floor = current_floor;

    case (current_floor)
      S1: begin
        if (floor_req > S1)
          next_floor = S2;
      end

      S2: begin
        if (floor_req < S2)
          next_floor = S1;
        else if (floor_req > S2)
          next_floor = S3;
      end

      S3: begin
        if (floor_req < S3)
          next_floor = S2;
        else if (floor_req > S3)
          next_floor = S4;
      end

      S4: begin
        if (floor_req < S4)
          next_floor = S3;
        else if (floor_req > S4)
          next_floor = S5;
      end

      S5: begin
        if (floor_req < S5)
          next_floor = S4;
      end

      default: begin
        next_floor = S1;
      end
    endcase
  end

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      current_floor <= S1;
    end else begin
      if (one_sec_tick) begin
        current_floor <= next_floor;
      end else begin
        current_floor <= current_floor;
      end
    end
  end

endmodule