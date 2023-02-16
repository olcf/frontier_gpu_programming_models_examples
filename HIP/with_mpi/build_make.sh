#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

if [[ -z "$CXX_COMPILER" ]]; then
CXX_COMPILER="hipcc" # can be: CC | hipcc . 
fi


export CRAY_CPU_TARGET=x86-64


mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../vAdd_hip.cpp .


module purge
module load DefApps

if [[ ${CXX_COMPILER} == "CC" ]]; then
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
make -f Makefile


elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
module load PrgEnv-gnu
module load rocm
make -f Makefile.hipcc
fi

echo
echo
if [[ -f "$(pwd)/vAdd_hip"  ]]; then
echo "Executable 'vAdd_hip' is in the make_build_dir directory"
fi

