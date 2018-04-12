#!/bin/bash
#SBATCH -N 1
#SBATCH -t 10
#SBATCH --reservation=demokun
STARTDIR=`pwd`
echo "%NProcShared = 16" > $TMPDIR/molecule.inp
echo "#RHF/6-31G Opt" >> $TMPDIR/molecule.inp
echo "" >> $TMPDIR/molecule.inp
echo "My molecule" >> $TMPDIR/molecule.inp
echo "" >> $TMPDIR/molecule.inp
echo "0,1" >> $TMPDIR/molecule.inp
cat molecule.zmat >> $TMPDIR/molecule.inp
cd $TMPDIR
module load g16
g16 < molecule.inp
