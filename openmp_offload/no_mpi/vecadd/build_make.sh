#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

CXX_COMPILER="hipcc" # can be: hipcc | CC . CC uses Makefile. hipcc uses Makefile.hipcc


mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../vecadd.cpp .

module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm/5.1.0

echo ${CXX_COMPILER}

if [[ ${CXX_COMPILER} == "CC" ]]; then
echo "building with CC"
make 
elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
echo "building with hipcc"
make -f Makefile.hipcc
fi

echo
echo
echo "Executable 'vecadd' is in the make_build_dir directory"

