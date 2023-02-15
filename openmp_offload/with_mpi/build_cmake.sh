#!/bin/bash


# Options you can adjust

if [[ -z "$C_COMPILER" ]]; then
C_COMPILER="hipcc" # can be: cc | hipcc . 
fi

echo "C_COMPILER: $C_COMPILER"

export CRAY_CPU_TARGET=x86-64

mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*


module purge
module load DefApps

if [[ ${C_COMPILER} == "cc" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm


elif [[ ${C_COMPILER} == "hipcc" ]]; then
module load PrgEnv-cray
module load rocm
fi


module load cmake/3.23.2
cmake -DCMAKE_C_COMPILER=${C_COMPILER} ..

VERBOSE=1 make

echo
echo
if [[ -f "$(pwd)/jacobi" ]]; then
echo "Executable 'jacobi' is in the cmake_build_dir directory"
fi
