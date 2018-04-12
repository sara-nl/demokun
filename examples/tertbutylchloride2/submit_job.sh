#!/bin/bash
#SBATCH -t 10
#SBATCH -n 1 
#SBATCH --reservation=demokun
nprocs=`cat /proc/cpuinfo | grep processor | wc -l`
for i in `seq 1 $nprocs`; do
   ./run_job.sh &
done
wait
