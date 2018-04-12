#!/bin/bash
module load stopos
rm -f parmpool.$$
for bl in `seq 1.6 0.1 10.0`; do
   echo $bl >> parmpool.$$
done
stopos -p bondlengths purge
stopos -p bondlengths create
stopos -p bondlengths add parmpool.$$
rm parmpool.$$
