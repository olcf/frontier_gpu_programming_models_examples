#!/bin/bash


mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*

CXX_COMPILER="hipcc" # can be CC | hipcc

# Building with Kokkos module (this module is only configured with ENABLE_HIP so need to use hipcc)
module load PrgEnv-cray
module load cmake/3.23.2
module load craype-accel-amd-gfx90a 
module load rocm/5.1.0
cmake -DCMAKE_CXX_COMPILER=${CXX_COMPILER}  ..

VERBOSE=1 make
