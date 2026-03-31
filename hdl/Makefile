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

# Verilator SystemVerilog testbench flags
V_SV_FLAGS = --trace --exe --build -cc --timing \
             --x-assign unique --x-initial unique \
             -Wno-TIMESCALEMOD -Wno-DECLFILENAME \
             -j $(shell nproc)

# iverilog configuration
IVERILOG = iverilog
IV_FLAGS = -Wall -g2005-sv -o sim_iv

# Targets
.PHONY: all clean run verilator iverilog run_iverilog verilator_sv run_sv help

# Default: Icarus Verilog (SystemVerilog testbench)
all: clean iverilog

# --- VERILATOR FLOW (C++ Testbench) ---
verilator: obj_dir/V$(TOP_MODULE)

obj_dir/V$(TOP_MODULE): $(V_SRC) $(CPP_SRC)
	$(VERILATOR) $(V_FLAGS) --top-module $(TOP_MODULE) $(V_SRC) $(CPP_SRC)

run: verilator
	./obj_dir/V$(TOP_MODULE)

make_gen: 
	mkdir gen/

# --- VERILATOR FLOW (SystemVerilog Testbench) ---
verilator_sv: obj_dir_sv/V$(TOP_MODULE)

obj_dir_sv/V$(TOP_MODULE): $(V_SRC) $(TB_SRC)
	$(VERILATOR) $(V_SV_FLAGS) --top-module tb_$(TOP_MODULE) $(V_SRC) $(TB_SRC)

run_sv: verilator_sv
	./obj_dir_sv/V$(TOP_MODULE)

# --- IVERILOG FLOW (Pure SystemVerilog Testbench) ---
iverilog: make_gen sim_iv run_iverilog

sim_iv: $(V_SRC) $(TB_SRC)
	$(IVERILOG) $(IV_FLAGS) -s tb_$(TOP_MODULE) $(V_SRC) $(TB_SRC)

run_iverilog: 
	./sim_iv

# --- CLEANUP ---
clean:
	rm -rf gen/ obj_dir/ obj_dir_sv/ *.vcd sim_iv

help:
	@echo "Usage (default: iverilog SystemVerilog testbench):"
	@echo "  make              - Build and run with iverilog (SystemVerilog testbench)"
	@echo "  make verilator    - Build with Verilator (C++ testbench)"
	@echo "  make run          - Run Verilator C++ testbench"
	@echo "  make verilator_sv - Build with Verilator (SystemVerilog testbench) - EXPERIMENTAL"
	@echo "  make run_sv       - Run Verilator SystemVerilog testbench - EXPERIMENTAL"
	@echo "  make iverilog     - Build with iverilog (SystemVerilog testbench)"
	@echo "  make run_iverilog - Run iverilog SystemVerilog testbench"
	@echo "  make clean        - Clean all generated files"