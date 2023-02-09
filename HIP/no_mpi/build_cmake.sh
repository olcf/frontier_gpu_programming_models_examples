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
module load cmake/3.23.2

if [[ ${CXX_COMPILER} == "CC" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with CC"

elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
module load PrgEnv-cray
module load rocm/5.1.0
EXTRA_CXX_FLAGS=
echo "building with hipcc"
fi

cmake -DCMAKE_CXX_COMPILER=${CXX_COMPILER} -DAMDGPU_TARGETS="gfx90a" ..

VERBOSE=1 make

echo "executable 'vAdd_hip' built in cmake_build_dir"
