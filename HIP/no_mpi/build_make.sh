#!/bin/bash

# Update the options below and run with ./build_make.sh

# Options you can adjust

if [[ -z "$CXX_COMPILER" ]]; then
CXX_COMPILER="hipcc" # can be: CC | hipcc . 
fi


mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile* ../vAdd_hip.hip .



if [[ ${CXX_COMPILER} == "CC" ]]; then
# If you're using PrgEnv-cray
#module load PrgEnv-cray
#module load craype-accel-amd-gfx90a 
#module load amd-mixed

# If you're using PrgEnv-amd
module load PrgEnv-amd
module load craype-accel-amd-gfx90a 


make -f Makefile


elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
# If you're using PrgEnv-cray
#module load PrgEnv-cray
#module load amd-mixed

# If you're using PrgEnv-amd
module load PrgEnv-amd

make -f Makefile.hipcc
fi

echo
echo
if [[ -f "$(pwd)/vAdd_hip"  ]]; then
echo "Executable 'vAdd_hip' is in the make_build_dir directory"
fi

