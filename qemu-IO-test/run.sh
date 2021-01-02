#!/bin/bash
echo "Press Ctrl-A and then X to exit QEMU"
echo
qemu-system-aarch64 -S -M raspi3 -kernel build/kernel8.img --nographic -gdb tcp::1234