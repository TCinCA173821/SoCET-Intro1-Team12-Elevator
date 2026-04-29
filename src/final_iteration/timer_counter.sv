module clock_timer (
  input  logic clk,
  input  logic reset,
  input  logic enable,
  output logic clk_div2,
  output logic one_sec_tick
);

  logic d;
  logic [6:0] count;

  assign d = ~clk_div2;

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      clk_div2 <= 1'b0;
    end else begin
      clk_div2 <= d;
    end
  end

  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      count <= 7'd0;
      one_sec_tick <= 1'b0;
    end else begin
      one_sec_tick <= 1'b0;

      if (enable) begin
        if (count == 7'd99) begin
          count <= 7'b0;
          one_sec_tick <= 1'b1;
        end else begin
          count <= count + 7'd1;
        end
      end else begin
        count <= 7'd0;
      end
    end
  end

endmodule