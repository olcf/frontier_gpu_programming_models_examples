#!/bin/bash



mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*

export CRAYPE_LINK_TYPE=dynamic

# Building with in tree build (comment out one or the other for OpenMP or HIP)
module load rocm
module load cmake
#cmake  -DCMAKE_CXX_COMPILER=CC -DKokkos_ENABLE_OPENMP=ON -DKokkos_ENABLE_HIP=OFF ..
#cmake  -DCMAKE_CXX_COMPILER=hipcc -DKokkos_ENABLE_OPENMP=OFF -DKokkos_ENABLE_HIP=ON ..
cmake  -DCMAKE_CXX_COMPILER=hipcc -DKokkos_ENABLE_OPENMP=ON -DKokkos_ENABLE_HIP=ON ..

# Building with Kokkos module (this module is only configured with ENABLE_HIP so need to use hipcc)
#module load  kokkos/3.6.00
#cmake -DCMAKE_CXX_COMPILER=hipcc  ..


VERBOSE=1 make
