CROSS_COMPILE = aarch64-elf-
CC = $(CROSS_COMPILE)gcc
CFLAGS = -Wall -fno-common -O0 -g \
         -nostdlib -nostartfiles -ffreestanding \
         -march=armv8-a

kernel8.img: linker.ld boot.o hello.o
	aarch64-elf-ld boot.o hello.o -T linker.ld -o kernel8.img
	aarch64-elf-objdump -d kernel8.img > kernel.list
	aarch64-elf-objdump -t kernel8.img | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > kernel.sym

boot.o: boot.S
	aarch64-elf-gcc -c boot.S -o boot.o

basicfct:
	aarch64-linux-gnu-as -o basicfct.o basicfct.S
	aarch64-linux-gnu-ld -s -o basicfct basicfct.o

clean:
	rm -f kernel8.img *.o *.list *.sym basicfct

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
