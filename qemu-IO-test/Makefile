CROSS_COMPILE = aarch64-elf-
CC_NO_QEMU = aarch64-linux-gnu-
CC = $(CROSS_COMPILE)gcc
KERNEL_FILE = kernel8.img
CFLAGS = -Wall -fno-common -O0 -g \
         -nostdlib -nostartfiles -ffreestanding \
         -march=armv8-a

kernel8.img: linker.ld boot.o hello.o
	$(CROSS_COMPILE)ld boot.o hello.o -T linker.ld -o $(KERNEL_FILE)
	$(CROSS_COMPILE)objdump -d $(KERNEL_FILE) > kernel.list
	$(CROSS_COMPILE)objdump -t $(KERNEL_FILE) | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > kernel.sym

boot.o: boot.S
	$(CC) -c boot.S -o boot.o

basicfct:
	$(CC_NO_QEMU)as -o basicfct.o basicfct.S
	$(CC_NO_QEMU)ld -s -o basicfct basicfct.o

clean:
	rm -f $(KERNEL_FILE) *.o *.list *.sym basicfct

.PHONY: all qemu clean


# assembler compile:
# aarch64-elf-as -c boot.S -o boot.o

# c compile:
# aarch64-elf-gcc -ffreestanding -c hello.c -o hello.o -O2 -Wall -Wextra

# link kernel (doesn't work properly though?)
# aarch64-elf-gcc -T linker.ld -o myos.elf -ffreestanding -O2 -nostdlib boot.o hello.o -lgcc 
# aarch64-elf-objcopy myos.elf -O binary kernel8.img

# run emulator
# qemu-system-aarch64 -M raspi3 -serial mon:stdio -kernel kernel8.img --nographic
# extra / removable flags: 
# -serial mon:stdio (input works buggy)
