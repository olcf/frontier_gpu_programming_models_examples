#!/bin/bash


mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*

if [[ -z "$PROGRAMMING_ENVIRONMENT" ]]; then
PROGRAMMING_ENVIRONMENT="cray" # can be: cray | amd . 
fi
export CRAY_CPU_TARGET=x86-64

module purge
module load DefApps


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

module load cmake/3.23.2
cmake ..

VERBOSE=1 make

echo "executable 'jacobi' built in cmake_build_dir"
