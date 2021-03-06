#!/bin/bash
module load stopos
MYTEMP=`mktemp -d ${TMPDIR}/tert.XXXX`
MYHOME=${HOME}/demokun/examples/tertbutylchloride2
cd ${MYTEMP}
STOPOS_RC="OK"
while [ "$STOPOS_RC" == "OK" ]; do
   stopos -p bondlengths next
   if [ "$STOPOS_RC" == "OK" ]; then
      cat ${MYHOME}/template | sed "s/LENGTH/$STOPOS_VALUE/g" > input_$STOPOS_VALUE
      ${HOME}/demokun/bin/gamess < input_$STOPOS_VALUE > ${MYHOME}/output_$STOPOS_VALUE
   fi
done
rm -rf ${MYTEMP}
