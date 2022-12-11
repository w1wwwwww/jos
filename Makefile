all: iso

config:
	$(MAKE) -C src config

clean:
	$(MAKE) -C src clean

	rm -rf sysroot
	rm -rf jos.iso

headers:
	$(MAKE) -C src headers

build:
	$(MAKE) -C src build

iso:
	$(MAKE) -C src iso

	mv src/sysroot sysroot
	mv src/jos.iso jos.iso

test: iso
	qemu-system-i386 -cdrom jos.iso -serial file:serial.log