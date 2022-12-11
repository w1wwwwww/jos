# jos

jos is an operating system that exists

## Building

### Requirements

Building is currently only supported on linux systems.

A GCC and binutils cross-compiler built according to [https://wiki.osdev.org/GCC_Cross-Compiler](https://wiki.osdev.org/GCC_Cross-Compiler). The compiler must be able to be called by i686-elf-gcc.

xorriso and mtools are required for normal builds.
qemu-system-i386 is required for make test.

### Compiling

make iso will create an iso that can be run in a vm.

### Testing

make test will call make iso and run it in qemu. Additional emulator support will be added at a later date.
