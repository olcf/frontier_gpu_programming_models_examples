#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

if [[ -z "$CXX_COMPILER" ]]; then
CXX_COMPILER="hipcc" # can be: CC | hipcc . 
fi


mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../cpu_gpu_dgemm.hip .

export CRAY_CPU_TARGET=x86-64


if [[ ${CXX_COMPILER} == "CC" ]]; then
module load PrgEnv-cray
module load amd-mixed
module load craype-accel-amd-gfx90a

# If you're using PrgEnv-amd
#module load PrgEnv-amd
#module load craype-accel-amd-gfx90a 

module load openblas/0.3.17
make -f Makefile


elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
module load PrgEnv-cray
module load amd-mixed
 
# If you're using PrgEnv-amd
#module load PrgEnv-amd

module load openblas/0.3.17
make -f Makefile.hipcc
fi

echo
echo
if [[ -f "$(pwd)/cpu_gpu_dgemm"  ]]; then
echo "Executable 'cpu_gpu_dgemm' is in the make_build_dir directory"
fi

