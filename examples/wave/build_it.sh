#!/bin/bash
module load gcc/4.8.1
module load hdf5/gnu
module load openmpi/gnu/1.6.5
export HDF5_LIB_DIR=${HDF5_LIBRARY_PATH}
make
mv wave ~/bin
cp run_wave ~/bin
cp h52anim.pl ~/bin/h52anim
