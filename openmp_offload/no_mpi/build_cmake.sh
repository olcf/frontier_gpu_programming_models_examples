#!/bin/bash


mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*

PROGRAMMING_ENVIRONMENT="amd" # can be: cray | amd .
export CRAY_CPU_TARGET=x86-64

module purge
module load DefApps
module load cmake/3.23.2


if [[ ${PROGRAMMING_ENVIRONMENT} == "cray" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with cray"

elif [[ ${PROGRAMMING_ENVIRONMENT} == "amd" ]]; then
module load PrgEnv-amd
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with amd"
fi

cmake ..

VERBOSE=1 make

echo "executable 'jacobi' built in cmake_build_dir"
