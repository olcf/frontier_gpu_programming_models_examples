#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

if [[ -z "$PROGRAMMING_ENVIRONMENT" ]]; then
PROGRAMMING_ENVIRONMENT="hipcc" # can be: cray | amd . 
fi

export CRAY_CPU_TARGET=x86-64


mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../jacobi.c .


echo ${PROGRAMMING_ENVIRONMENT}
module purge
module load DefApps

if [[ ${PROGRAMMING_ENVIRONMENT} == "cray" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with cray"
make -f Makefile

elif [[ ${PROGRAMMING_ENVIRONMENT} == "amd" ]]; then
module load PrgEnv-amd
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with amd"
make -f Makefile

elif [[ ${PROGRAMMING_ENVIRONMENT} == "hipcc" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.1.0
echo "building with hipcc"
make -f Makefile.hipcc
fi

echo
echo
echo "Executable 'jacobi' is in the make_build_dir directory"

