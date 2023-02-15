#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

if [[ -z "$CXX_COMPILER" ]]; then
CXX_COMPILER="hipcc" # can be: CC | hipcc . 
fi


mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../cpu_gpu_dgemm.cpp .

export CRAY_CPU_TARGET=x86-64

module purge
module load DefApps

if [[ ${CXX_COMPILER} == "CC" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
module load openblas/0.3.17
make -f Makefile


elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
module load PrgEnv-cray
module load rocm
module load openblas/0.3.17
make -f Makefile.hipcc
fi

echo
echo
if [[ -f "$(pwd)/cpu_gpu_dgemm"  ]]; then
echo "Executable 'cpu_gpu_dgemm' is in the make_build_dir directory"
fi

