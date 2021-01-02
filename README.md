# raspberry-kernel-tests

## qemo-IO-test

based off https://github.com/jserv/armv8-hello and https://wiki.osdev.org/ARM_RaspberryPi_Tutorial_C

Run a custom kernel on a hardware-emulated raspberry pi 3.

to run qemu-io-test:
- ./run.sh
- run Debug QEMU launc configuration

notes:
- since raspberry pi 4 is not yet supported by qemu raspi3 is running
- WSL doesn't keep PATH vars, in case .bashrc doesn't work, on reboot: export PATH=/opt/linaro/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-elf/bin:$PATH
