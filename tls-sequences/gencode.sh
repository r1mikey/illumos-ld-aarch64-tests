#!/bin/sh

#
# -mtls-dialect=[desc|trad]
# -mtls-size=[12|24|32|48] 
# -ftls-model=[global-dynamic|local-dynamic|initial-exec|local-exec]
#   The default without -fpic is ‘initial-exec’; with -fpic the default is ‘global-dynamic’.
# https://gcc.gnu.org/onlinedocs/gcc/Thread-Local.html
#
/ws/cross-extra/proto/armv8/usr/gcc/7/bin/aarch64-unknown-elf-gcc -fPIC -mtls-dialect=trad -ftls-model=global-dynamic -c -o gd.o gd.c
# XXX: this isn't generating what I want!
/ws/cross-extra/proto/armv8/usr/gcc/7/bin/aarch64-unknown-elf-gcc -fPIC -mtls-dialect=trad -ftls-model=local-dynamic -c -o ld.o ld.c
/ws/cross-extra/proto/armv8/usr/gcc/7/bin/aarch64-unknown-elf-gcc -fPIC -mtls-dialect=trad -ftls-model=initial-exec -c -o ie.o ie.c
/ws/cross-extra/proto/armv8/usr/gcc/7/bin/aarch64-unknown-elf-gcc -mtls-dialect=trad -ftls-model=local-exec -c -o le.o le.c
# /opt/ooce/llvm-13.0/bin/llvm-objdump -r -d --disassemble-zeroes --section=.text gd.o

/ws/cross-extra/proto/armv8/usr/gnu/bin/gas -o main.o main.s

/ws/cross-extra/proto/armv8/usr/gnu/bin/gld -o le.exe main.o le.o
