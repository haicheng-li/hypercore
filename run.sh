#!/bin/bash

qemu-system-riscv32 -bios none -kernel hc.elf -s -S
#qemu-system-riscv32 -bios none -kernel hc.bin -s -S
