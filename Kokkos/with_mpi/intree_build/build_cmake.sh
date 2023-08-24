#!/bin/bash

# Update the options below and run with ./build_cmake.sh

# Options you can adjust

PRGENV="PrgEnv-amd" # can be: PrgEnv-cray | PrgEnv-gnu | PrgEnv-amd
CXX_COMPILER="hipcc" # can be: hipcc | CC . hipcc for GPU backend. CC for CPU backend only.
ENABLE_OPENMP=ON     # can be: ON | OFF
ENABLE_HIP=ON      # can be: ON | OFF . Will not work with CXX_COMPILER=CC
ZEN3_ARCH=ON
VEGA90A_ARCH=ON   # automatically ignored if Kokkos_ENABLE_HIP=OFF



export CRAYPE_LINK_TYPE=dynamic

mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*

module load ${PRGENV}
if [[ "$PRGENV" != PrgEnv-amd ]]; then
module load amd-mixed 
fi
module load cmake
cmake  \
    -DCMAKE_CXX_COMPILER=${CXX_COMPILER} \
    -DKokkos_ENABLE_OPENMP=${ENABLE_OPENMP} \
    -DKokkos_ENABLE_HIP=${ENABLE_HIP} \
    -DKokkos_ARCH_ZEN3=${ZEN3_ARCH} \
    -DKokkos_ARCH_VEGA90A=${VEGA90A_ARCH} \
    ..

VERBOSE=1 make

echo
echo
echo "Executable 'kokkos_example' is in the cmake_build_dir directory"

