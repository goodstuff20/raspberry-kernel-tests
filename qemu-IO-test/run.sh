#!/bin/bash
echo "Press Ctrl-A and then X to exit QEMU"
echo
qemu-system-aarch64 -M raspi3 -kernel kernel8.img --nographic -d int