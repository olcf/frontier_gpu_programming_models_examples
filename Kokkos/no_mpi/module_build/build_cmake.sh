#!/bin/bash



mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*

export CRAYPE_LINK_TYPE=dynamic


# Building with Kokkos module (this module is only configured with ENABLE_HIP so need to use hipcc)
module load  kokkos/3.6.00
module load rocm
cmake -DCMAKE_CXX_COMPILER=hipcc  ..


VERBOSE=1 make
