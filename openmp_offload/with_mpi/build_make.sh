#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

if [[ -z "$C_COMPILER" ]]; then
C_COMPILER="hipcc" # can be: cc | hipcc . 
fi

echo "C_COMPILER: $C_COMPILER"

export CRAY_CPU_TARGET=x86-64


mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../jacobi.c .


module purge
module load DefApps

if [[ ${C_COMPILER} == "cc" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
make -f Makefile


elif [[ ${C_COMPILER} == "hipcc" ]]; then
module load PrgEnv-cray
module load rocm
make -f Makefile.hipcc
fi


echo
echo
if [[ -f "$(pwd)/jacobi" ]]; then
echo "Executable 'jacobi' is in the make_build_dir directory"
fi

