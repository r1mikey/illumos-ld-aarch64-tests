#!/bin/sh -e

LD=/ws/illumos-gate/proto/root_i386/usr/bin/amd64/ld
ILLUMOS_LD_LD_LIBRARY_PATH=/ws/illumos-gate/proto/root_i386/lib/64
AS="/opt/ooce/llvm-13.0/bin/llvm-mc -filetype=obj -triple=aarch64"
OBJDUMP="/opt/ooce/llvm-13.0/bin/llvm-objdump"

TSTSRC0=aarch64-tlsie_adr_gottprel_page21.s
TSTSRC1=../common/tlsfoodata.s
TSTOBJ0=0000-aarch64-tlsie_adr_gottprel_page21.o
TSTOBJ1=0000-tlsfoodata.o
TSTBIN=0000-t.exe

EXPECTED_STDOUT=0000-aarch64-tlsie_adr_gottprel_page21.expected.stdout
EXPECTED_STDERR=0000-aarch64-tlsie_adr_gottprel_page21.expected.stderr

ACTUAL_STDOUT=0000-aarch64-tlsie_adr_gottprel_page21.actual.stdout
ACTUAL_STDERR=0000-aarch64-tlsie_adr_gottprel_page21.actual.stderr

rm -f ${TSTOBJ0} ${TSTBIN} ${ACTUAL_STDOUT} ${ACTUAL_STDERR}

if [ x"${1}" = x"clean" ]; then
  exit 0
fi

${AS} -o ${TSTOBJ0} ${TSTSRC0}
${AS} -o ${TSTOBJ1} ${TSTSRC1}

LD_LIBRARY_PATH=${ILLUMOS_LD_LD_LIBRARY_PATH} \
  ${LD} -z type=exec -o ${TSTBIN} ${TSTOBJ0} ${TSTOBJ1}
exit 0
${OBJDUMP} -s --section=.text ${TSTBIN} 1> ${ACTUAL_STDOUT} 2> ${ACTUAL_STDERR}
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
