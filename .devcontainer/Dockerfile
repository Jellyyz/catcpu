FROM fedora:43

RUN dnf install -y \
    verilator \
    yosys \
    iverilog \
    gcc \
    g++ \
    gcc-riscv64-linux-gnu \
    binutils-riscv64-linux-gnu \
    python3-pip \
    make \
    git \
    gtkwave \
    && dnf clean all

WORKDIR /workspaces/catcpu