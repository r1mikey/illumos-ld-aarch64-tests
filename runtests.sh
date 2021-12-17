#!/bin/sh

total=0
pass=0
fail=0

for t in aarch64-[0-9][0-9][0-9][0-9]-*/test[0-9][0-9][0-9][0-9].sh; do
  TN=$(dirname $t)
  SN=$(basename $t)
  ST=$(basename ${SN} .sh)
  cd ${TN}
  ./${SN} > /dev/null 2>&1
  RES=$?
  cd ..
  total=$(( total + 1 ))
  if [ $RES -eq 0 ]; then
    echo "PASS: ${TN}::${ST}"
    pass=$(( pass + 1 ))
  else
    echo "FAIL: ${TN}::${ST}"
    fail=$(( fail + 1 ))
  fi
done

echo ""
echo "================================================================================"
echo " Pass: ${pass} of ${total}"
echo " Fail: ${fail} of ${total}"
echo "================================================================================"

if [ ${pass} -eq ${total} ]; then
  exit 0
fi

exit 1
