`timescale 1ns / 1ps

module tb_catcpu;
    // Clock and reset signals
    logic clk;
    logic nreset;

    // Instantiate the DUT (Device Under Test)
    catcpu dut (
        .clk(clk),
        .nreset(nreset)
    );

    // Clock generation: 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        nreset = 0;  // Assert reset
        #20;         // Hold reset for 20ns
        nreset = 1;  // Deassert reset
    end

    // Test stimulus
    initial begin
        $dumpfile("../hdl/gen/icarus_out.vcd");
        $dumpvars();

        // Wait for reset to complete
        @(posedge nreset);

        // Run simulation for 1000 cycles (10000ns) after reset
        #10000;

        // Exit simulation
        $finish;
    end

endmodule
