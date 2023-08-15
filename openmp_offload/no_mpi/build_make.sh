#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

if [[ -z "$C_COMPILER" ]]; then
C_COMPILER="hipcc" # can be: cc | hipcc . 
fi

echo "C_COMPILER: $C_COMPILER"



mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../jacobi.c .



if [[ ${C_COMPILER} == "cc" ]]; then
# If using cray environment
module load PrgEnv-cray
module load amd-mixed
module load craype-accel-amd-gfx90a


# If using amd environment
#module load PrgEnv-amd
#module load craype-accel-amd-gfx90a

make -f Makefile


elif [[ ${C_COMPILER} == "hipcc" ]]; then
# If using cray environment
#module load PrgEnv-cray
#module load amd-mixed

# If using amd environment
module load PrgEnv-amd

make -f Makefile.hipcc
fi


echo
echo
if [[ -f "$(pwd)/jacobi" ]]; then
echo "Executable 'jacobi' is in the make_build_dir directory"
fi

