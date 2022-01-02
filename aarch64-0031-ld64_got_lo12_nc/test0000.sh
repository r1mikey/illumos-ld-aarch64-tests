#!/bin/sh -e

ASMSRC1=aarch64-ld64_got_lo12_nc.s
FOOSRC=../common/foo.s

AS=/ws/cross-extra/proto/armv8/usr/gnu/bin/gas
LD=/ws/illumos-gate/proto/root_i386/usr/bin/amd64/ld
# LD=/ws/illumos-gate/proto/root_i386/usr/bin/ld
# LD=/ws/cross-extra/proto/armv8/usr/gnu/bin/gld
MC="/opt/ooce/llvm-13/bin/llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd"

rm -f *.exe *.o *.so core *.actual

if [ x"${1}" = x"clean" ]; then
  exit 0
fi

${MC} -o t1.o ${ASMSRC1}
${MC} -o foo.o ${FOOSRC}
LD_LIBRARY_PATH=/ws/illumos-gate/proto/root_i386/lib/64 \
  ${LD} -z type=exec -o t1.exe t1.o foo.o
/opt/ooce/llvm-13/bin/llvm-objdump -s --section=.text t1.exe > t1.actual
if ! cmp -s t1.expected t1.actual; then
  echo "FAIL: [0] mismatched output" 1>&2
  exit 1
fi

rm -f *.exe *.o *.so core *.actual
echo "PASS"
exit 0
