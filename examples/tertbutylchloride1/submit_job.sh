#!/bin/bash
#SBATCH -t 10
#SBATCH -n 1 
#SBATCH --reservation=demokun
for i in "1.6 1.8 1.9 2.0 2.1 2.2 2.5 3.0 5.0 10.0" ; do
   ./run_job.sh ${i} &
done
wait
