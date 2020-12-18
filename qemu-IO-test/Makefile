CROSS_COMPILE = aarch64-elf-
CC_NO_QEMU = aarch64-linux-gnu-
CC = $(CROSS_COMPILE)gcc
KERNEL_FILE = kernel8.img
#CFLAGS = -Wall -fno-common -O0 -g \
         -nostdlib -nostartfiles -ffreestanding \
         -march=armv8-a \
		 -Iinclude
#CFLAGS = -Iinclude
CFLAGS = -Wall -nostdlib -nostartfiles -ffreestanding -Iinclude -mgeneral-regs-only
SFLAGS = -Iinclude

C_FILES = $(wildcard src/*.c)
S_FILES = $(wildcard src/*.S)
O_FILES = $(C_FILES:src/%.c=build/%_c.o)
O_FILES += $(S_FILES:src/%.S=build/%_s.o)

kernel8.img: src/linker.ld $(O_FILES) # boot.o hello.o
	$(CROSS_COMPILE)ld $(O_FILES) -T src/linker.ld -o build/$(KERNEL_FILE)
	$(CROSS_COMPILE)objdump -d build/$(KERNEL_FILE) > build/kernel.list
	$(CROSS_COMPILE)objdump -t build/$(KERNEL_FILE) | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > build/kernel.sym

# kernel8.img: src/linker.ld $(O_FILES)
# 	$(CROSS_COMPILE)ld -T src/linker.ld -o build/kernel8.elf $(O_FILES)
# 	$(CROSS_COMPILE)objcopy build/kernel8.elf -O binary kernel8.img

build/%_c.o: src/%.c
	mkdir -p build
	$(CC) -c $(CFLAGS) $< -o $@

build/%_s.o: src/%.S
	$(CC) -c $(SFLAGS) $< -o $@

# boot.o: boot.S
# 	$(CC) -c boot.S -o boot.o
# 	$(CC) -c irq.S -o irq.o
# 	$(CC) -c vector.S -o vector.o

# basicfct: clean
# 	$(CC_NO_QEMU)as -o basicfct.o basicfct.S
# 	$(CC_NO_QEMU)ld -s -o basicfct basicfct.o

#rm -f build/$(KERNEL_FILE) build/*.o build/*.list build/*.sym build/basicfct
clean: # cannot remove a directory in windows w/o permissions...
	rm -f build/*


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
