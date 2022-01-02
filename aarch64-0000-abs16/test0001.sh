#!/bin/sh -e

TESTNUM="0001"

LD=/ws/illumos-gate/proto/root_i386/usr/bin/amd64/ld
ILLUMOS_LD_LD_LIBRARY_PATH=/ws/illumos-gate/proto/root_i386/lib/64
AS="/opt/ooce/llvm-13/bin/llvm-mc -filetype=obj -triple=aarch64"
OBJDUMP="/opt/ooce/llvm-13/bin/llvm-objdump"

TSTSRC0=aarch64-abs16.s
TSTOBJ0=${TESTNUM}-aarch64-abs16.o
TSTSRC1=../common/abs255.s
TSTOBJ1=${TESTNUM}-abs255.o
TSTBIN=${TESTNUM}-t.exe

EXPECTED_STDOUT=${TESTNUM}-aarch64-abs16.expected.stdout
EXPECTED_STDERR=${TESTNUM}-aarch64-abs16.expected.stderr

ACTUAL_STDOUT=${TESTNUM}-aarch64-abs16.actual.stdout
ACTUAL_STDERR=${TESTNUM}-aarch64-abs16.actual.stderr

rm -f ${TSTOBJ0} ${TSTOBJ1} ${TSTBIN} ${ACTUAL_STDOUT} ${ACTUAL_STDERR}

if [ x"${1}" = x"clean" ]; then
  exit 0
fi

${AS} -o ${TSTOBJ0} ${TSTSRC0}
${AS} -o ${TSTOBJ1} ${TSTSRC1}

set +e
LD_LIBRARY_PATH=${ILLUMOS_LD_LD_LIBRARY_PATH} \
  ${LD} -z type=exec -o ${TSTBIN} ${TSTOBJ0} ${TSTOBJ1} 1> ${ACTUAL_STDOUT} 2> ${ACTUAL_STDERR}
if [ $? -eq 0 ]; then
  echo "FAIL: [0] unexpected success from ld" 1>&2
  exit 1
fi
set -e
if ! cmp -s ${EXPECTED_STDOUT} ${ACTUAL_STDOUT}; then
  echo "FAIL: [0] mismatched stdout" 1>&2
  exit 1
fi
if ! cmp -s ${EXPECTED_STDERR} ${ACTUAL_STDERR}; then
  echo "FAIL: [0] mismatched stderr" 1>&2
  exit 1
fi

rm -f ${TSTOBJ0} ${TSTOBJ1} ${TSTBIN} ${ACTUAL_STDOUT} ${ACTUAL_STDERR}
echo "PASS"
exit 0
