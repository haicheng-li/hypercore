#!/bin/bash

set -x

#qemu-system-riscv32 -machine virt -bios none -kernel hc.elf -s -S -serial pty
#qemu-system-riscv32 -bios none -kernel hc.bin -s -S
qemu-system-riscv64 -machine virt -bios none -kernel hc.elf -s -S -serial pty
