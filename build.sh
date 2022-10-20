#!/bin/bash

riscv-none-elf-as -ggdb3 -o hello.o hello.s
riscv-none-elf-ld -T hc.ld -o hc.elf hello.o
#riscv-none-elf-objcopy hc.elf -O binary hc.bin
