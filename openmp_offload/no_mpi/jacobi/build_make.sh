#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

CXX_COMPILER="gnu" # can be: hipcc | cc | gnu . cc uses Makefile. hipcc uses Makefile.hipcc.
                  # gnu uses Makefile.gnu .


mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../jacobi.c .


echo ${CXX_COMPILER}

if [[ ${CXX_COMPILER} == "cc" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with CC"
make 
elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with hipcc"
make -f Makefile.hipcc
elif [[ ${CXX_COMPILER} == "gnu" ]]; then
module load PrgEnv-gnu
module load gcc/12.2.0
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with gnu"
make -f Makefile.gnu
fi

echo
echo
echo "Executable 'jacobi' is in the make_build_dir directory"

