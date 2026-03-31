`timescale 1ns / 1ps

module catcpu (
    // connect to testbench
    input logic clk,
    input logic nreset


);

logic [15:0] counter;

always_ff @(posedge clk or negedge nreset) begin
    if (!nreset) begin
        counter <= 16'b0;
    end else begin
        counter <= counter + 1'b1;
    end
end






endmodule