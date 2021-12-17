#!/bin/sh -e

ASMSRC1=aarch64-abs32.s
ASMSRC2=../common/abs255.s
ASMSRC3=../common/abs256.s
ASMSRC4=../common/abs257.s

AS=/ws/cross-extra/proto/armv8/usr/gnu/bin/gas
LD=/ws/illumos-gate/proto/root_i386/usr/bin/amd64/ld
# LD=/ws/illumos-gate/proto/root_i386/usr/bin/ld
# LD=/ws/cross-extra/proto/armv8/usr/gnu/bin/gld
MC="/opt/ooce/llvm-13.0/bin/llvm-mc -filetype=obj -triple=aarch64"

rm -f *.exe *.o *.so core *.actual

if [ x"${1}" = x"clean" ]; then
  exit 0
fi

# dump the PLT: /ws/cross-extra/proto/armv8/usr/gnu/bin/gobjdump -w -D -s --section=.plt t1.so
# dump the GOT with: /ws/cross-extra/proto/armv8/usr/gnu/bin/gobjdump -w -D -s --section=.got t1.so
# dump relocation entries: /ws/cross-extra/proto/armv8/usr/gnu/bin/gobjdump -w -r t1.so
# dump dynamic relocation entries: /ws/cross-extra/proto/armv8/usr/gnu/bin/gobjdump -w -R t1.so

# ^^^ no GOT for the PLT only in Solaris, so we need to trawl the actual GOT

#
# RUN: llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd %s -o %t
# RUN: echo '.globl zero; zero = 0' | llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd -o %t2.o
# RUN: ld.lld %t %t2.o -o %t2
# RUN: llvm-objdump -d %t2 | FileCheck %s
#

if [ x"${1}" = x"gnu" ]; then
  LD=/ws/cross-extra/proto/armv8/usr/gnu/bin/gld.bfd
  # llvm-mc -filetype=obj -triple=aarch64 %s -o %t.o
  ${MC} -o t1.o ${ASMSRC1}
  ${MC} -o t2.o ${ASMSRC2}
  ${MC} -o t3.o ${ASMSRC3}
  ${MC} -o t4.o ${ASMSRC4}
  # ld.lld %t.o %t256.o -o %t
  ${LD} -o t1 t1.o t3.o
  ${LD} -o t2 t1.o t2.o
  ${LD} -o t3 t1.o t4.o
  exit 0
fi

#rm -f core t-000 basic-aarch64 *.o
#${AS} -o basic-aarch64.o basic-aarch64.s
#LD_LIBRARY_PATH=/ws/illumos-gate/proto/root_i386/lib/64 ${LD} -D all -o basic-aarch64 basic-aarch64.o

${MC} -o t1.o ${ASMSRC1}
${MC} -o t2.o ${ASMSRC2}
${MC} -o t3.o ${ASMSRC3}
${MC} -o t4.o ${ASMSRC4}
LD_LIBRARY_PATH=/ws/illumos-gate/proto/root_i386/lib/64 \
  ${LD} -z type=exec -o t3.exe t1.o t3.o
/opt/ooce/llvm-13.0/bin/llvm-objdump -s --section=.data t3.exe > t3.actual
if ! cmp -s t3.expected t3.actual; then
  echo "FAIL: [0] mismatched output" 1>&2
  exit 1
fi

# ld.lld %t.o %t255.o -o /dev/null 2>&1
#LD_LIBRARY_PATH=/ws/illumos-gate/proto/root_i386/lib/64 \
#  ${LD} -Dall -zverbose -z type=exec -o /dev/null t1.o t2.o
#if [ $? -ne 0 ]; then
#  echo "FAIL: [0] unexpected exit code from ld" 1>&2
#  exit 1
#fi

#set +e
#OUTPUT=$(LD_LIBRARY_PATH=/ws/illumos-gate/proto/root_i386/lib/64 \
#  ${LD} -z type=exec -o /dev/null t1.o t4.o 2>&1)
#if [ $? -eq 0 ]; then
#  echo "FAIL: [1] unexpected exit code from ld" 1>&2
#  exit 1
#fi
#echo $OUTPUT | egrep -q 'ld: fatal: relocation error: 0x103: file t1.o: symbol foo: value 0xffffffffffff8001 does not fit'
#if [ $? -ne 0 ]; then
#  echo "FAIL: unexpected output from ld" 1>&2
#  exit 1
#fi

##echo '.globl zero; zero = 0' | ${MC} -o t2.o
#OUTPUT=$(LD_LIBRARY_PATH=/ws/illumos-gate/proto/root_i386/lib/64 \
#  ${LD} -z type=exec -o t2 t1.o t2.o 2>&1)
#echo $OUTPUT | egrep -q 'ld: fatal: relocation error: 0x103: file t1.o: symbol foo: value 0xfffe does not fit'
#if [ $? -ne 0 ]; then
#  echo "FAIL: [2] unexpected output from ld" 1>&2
#  exit 1
#fi

rm -f *.exe *.o *.so core *.actual
echo "PASS"
exit 0

# /opt/ooce/llvm-13.0/bin/llvm-objdump -s --section=.data t.exe
