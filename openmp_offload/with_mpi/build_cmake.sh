#!/bin/bash


# Options you can adjust

if [[ -z "$C_COMPILER" ]]; then
C_COMPILER="hipcc" # can be: cc | hipcc . 
fi

echo "C_COMPILER: $C_COMPILER"


mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*


if [[ ${C_COMPILER} == "cc" ]]; then
# If using cray environment
module load PrgEnv-cray
module load amd-mixed
module load craype-accel-amd-gfx90a

# If using amd environment
#module load PrgEnv-amd
#module load craype-accel-amd-gfx90a


elif [[ ${C_COMPILER} == "hipcc" ]]; then
# If using cray environment
module load PrgEnv-cray
module load amd-mixed

# If using amd environment
#module load PrgEnv-amd

fi


module load cmake/3.23.2
cmake -DCMAKE_C_COMPILER=${C_COMPILER} ..

VERBOSE=1 make

echo
echo
if [[ -f "$(pwd)/jacobi" ]]; then
echo "Executable 'jacobi' is in the cmake_build_dir directory"
fi
