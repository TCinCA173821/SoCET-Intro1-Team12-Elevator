module button_decoder (
    input  logic clk,
    input  logic reset,
    input  logic [5:1] pb,
    output logic [2:0] floor_req
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            floor_req <= 3'b001;
        end
        else if (pb[1]) begin
            floor_req <= 3'b001;
        end
        else if (pb[2]) begin
            floor_req <= 3'b010;
        end
        else if (pb[3]) begin
            floor_req <= 3'b011;
        end
        else if (pb[4]) begin
            floor_req <= 3'b100;
        end
        else if (pb[5]) begin
            floor_req <= 3'b101;
        end
    end

endmodule