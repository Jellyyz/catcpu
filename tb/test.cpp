#include "Vcatcpu.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    
    Vcatcpu* top = new Vcatcpu;
    VerilatedVcdC* tfp = new VerilatedVcdC;
    
    // Enable tracing
    Verilated::traceEverOn(true);
    top->trace(tfp, 99);
    tfp->open("sim.vcd");
    
    // Run simulation for 100 clock cycles
    for (int i = 0; i < 100; i++) {
        top->clk = (i % 2);  // Toggle clock
        top->eval();
        tfp->dump(i);
    }
    
    tfp->close();
    delete top;
    delete tfp;
    
    return 0;
}