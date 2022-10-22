#!/bin/bash

set -x

riscv-none-elf-gcc -ggdb3 -c *.s *.c
#riscv-none-elf-as -ggdb3 -o *.o *.s
riscv-none-elf-ld -T hc.ld -o hc.elf *.o
#riscv-none-elf-objcopy hc.elf -O binary hc.bin
