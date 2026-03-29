`timescale 1ns / 1ps

module tb_catcpu;
    // Clock signal
    logic clk;
    
    // Instantiate the DUT (Device Under Test)
    catcpu_if cpu_if (.clk(clk));
    
    catcpu dut (
        .clk(clk)
        // Add other ports as needed
    );
    
    // Clock generation: 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test stimulus
    initial begin
        // Enable waveform tracing
        $dumpfile("sim.vcd");
        $dumpvars(0, tb_catcpu);
        
        // Run simulation for 100 cycles (1000ns)
        #1000;
        
        // Exit simulation
        $finish;
    end
    
endmodule
