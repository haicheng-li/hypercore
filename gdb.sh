#!/bin/bash

set -x

riscv-none-elf-gdb -tui app.elf
#riscv-none-elf-gdb -tui hc.elf
