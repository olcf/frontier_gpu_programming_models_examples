#!/bin/bash

set -e
mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*
cp ../Makefile ../exercise_2_begin.cpp .

# For OpenMP backend
#make KOKKOS_DEVICES=OpenMP,Serial 

# for HIP backend
module load rocm
make KOKKOS_DEVICES=HIP,Serial CXX=hipcc

