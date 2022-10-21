SYSTEM_HEADER_PROJECTS=libc kernel
PROJECTS=libc kernel

HOST=i686-elf

export AR=${HOST}-ar
export AS=${HOST}-as
export CC=${HOST}-gcc

export PREFIX=/usr
export EXEC_PREFIX=${PREFIX}
export BOOTDIR=/boot
export LIBDIR=${EXEC_PREFIX}/lib
export INCLUDEDIR=${PREFIX}/include
export BUILDINCLUDEDIR=$(shell pwd)/sysroot/usr/include

export CFLAGS=-O2 -g -I $(BUILDINCLUDEDIR)
export CPPFLAGS=

# Configure the cross-compiler to use the desired system root.
export SYSROOT=${shell pwd}/sysroot
export CC:=${CC} --sysroot=${SYSROOT}

.PHONY: config headers build iso

all: iso

# Work around that the -elf gcc targets doesn't have a system include directory
# because it was configured with --without-headers rather than --with-sysroot.
config:
	if echo ${HOST} | grep -Eq -- '-elf($|-)'; then\
  		export CC:=${CC} -isystem=${INCLUDEDIR};\
	fi

clean: config
	$(foreach PROJECT, ${PROJECTS}, $(MAKE) -C ${PROJECT} clean;)

	rm -rf isodir

headers: config
	mkdir -p ${SYSROOT}
	$(foreach PROJECT, ${SYSTEM_HEADER_PROJECTS}, export DESTDIR=${SYSROOT} && $(MAKE) -C ${PROJECT} install-headers;)

build: headers
	$(foreach PROJECT, ${PROJECTS}, export DESTDIR=${SYSROOT} && $(MAKE) -C ${PROJECT} install;)

iso: build
	mkdir -p isodir
	mkdir -p isodir/boot
	mkdir -p isodir/boot/grub

	cp sysroot/boot/jos.kernel isodir/boot/jos.kernel
	cp grub.cfg isodir/boot/grub/grub.cfg

	grub-mkrescue -o jos.iso isodir
	