# --- Makefile for CPU Project: Supports both Verilator and iverilog ---

# Project Settings
TOP_MODULE = catcpu
V_SRC = $(shell find . -name "*.v" -or -name "*.sv")
TB_SRC = ../test/test.sv
CPP_SRC = ../tb/test.cpp

# Verilator configuration
VERILATOR = verilator
V_FLAGS = -Wall --trace --exe --build -cc \
          --x-assign unique --x-initial unique \
          -Isrc/include \
          -j $(shell nproc)

# iverilog configuration
IVERILOG = iverilog
IV_FLAGS = -Wall -o sim_iv

# Targets
.PHONY: all clean run verilator iverilog run_iverilog help

# Default: Verilator (C++ based)
all: verilator

# --- VERILATOR FLOW (C++ Testbench) ---
verilator: obj_dir/V$(TOP_MODULE)

obj_dir/V$(TOP_MODULE): $(V_SRC) $(CPP_SRC)
	$(VERILATOR) $(V_FLAGS) --top-module $(TOP_MODULE) $(V_SRC) $(CPP_SRC)

run: verilator
	./obj_dir/V$(TOP_MODULE)

# --- IVERILOG FLOW (Pure SystemVerilog Testbench) ---
iverilog: sim_iv

sim_iv: $(V_SRC) $(TB_SRC)
	$(IVERILOG) $(IV_FLAGS) -s tb_$(TOP_MODULE) $(V_SRC) $(TB_SRC)

run_iverilog: sim_iv
	./sim_iv

# --- CLEANUP ---
clean:
	rm -rf obj_dir *.vcd sim_iv

help:
	@echo "Usage:"
	@echo "  make verilator   - Build with Verilator (C++ testbench)"
	@echo "  make run         - Run Verilator simulation"
	@echo "  make iverilog    - Build with iverilog (SystemVerilog testbench)"
	@echo "  make run_iverilog - Run iverilog simulation"
	@echo "  make clean       - Clean all generated files"