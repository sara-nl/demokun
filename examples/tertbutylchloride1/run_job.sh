#!/bin/bash
if [ "x$1" == "x" ]; then
   echo "No bondlength given on command line"
   exit 123
fi
BONDLENGTH=${1}
MYTEMP=`mktemp -d ${TMPDIR}/tert.XXXX`
MYHOME=${HOME}/cartesius-demo/examples/tertbutylchloride
cd ${MYTEMP}
cat ${MYHOME}/template | sed "s/LENGTH/${BONDLENGTH}/g" > input_${BONDLENGTH}
${HOME}/cartesius-demo/bin/gamess < input_${BONDLENGTH} > ${MYHOME}/output_${BONDLENGTH}
rm -rf ${MYTEMP}
