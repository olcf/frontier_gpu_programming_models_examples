#!/bin/bash

# Options you can adjust

if [[ -z "$CXX_COMPILER" ]]; then
CXX_COMPILER="hipcc" # can be: CC | hipcc . 
fi
export CRAY_CPU_TARGET=x86-64

mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*

module purge
module load DefApps

if [[ ${CXX_COMPILER} == "CC" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
echo "building with CC"

elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
module load PrgEnv-gnu
module load rocm
echo "building with hipcc"
fi

module load cmake/3.23.2
cmake -DCMAKE_CXX_COMPILER=${CXX_COMPILER} -DAMDGPU_TARGETS="gfx90a" ..

VERBOSE=1 make

echo 
echo
if [[ -f "$(pwd)/vAdd_hip" ]]; then
echo "executable 'vAdd_hip' built in cmake_build_dir"
fi
