#!/bin/bash

# Update the options below and run with ./build_cmake.sh

# Options you can adjust

PRGENV="PrgEnv-amd" # can be: PrgEnv-cray | PrgEnv-gnu | PrgEnv-amd
CXX_COMPILER="hipcc" # can be: hipcc | CC . hipcc for GPU backend. CC for CPU backend only.
DEVICES="OpenMP,Serial" # can be: HIP,Serial | OpenMP,Serial . HIP,Serial for GPU backend. OpenMP,Serial for CPU backend.
ARCH="ZEN3,VEGA90A"        



export CRAYPE_LINK_TYPE=dynamic

mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile ../kokkos_example.cpp .

module load ${PRGENV}
module load rocm
if [[ ${CXX_COMPILER} == "CC" ]]; then
  make KOKKOS_DEVICES=${DEVICES} CXX=${CXX_COMPILER} KOKKOS_ARCH=${ARCH}
elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
  make KOKKOS_DEVICES=${DEVICES} CXX=${CXX_COMPILER} KOKKOS_ARCH=${ARCH} \
       CXXFLAGS="-I${MPICH_DIR}/include" LINKFLAGS="-L${MPICH_DIR}/lib -lmpi"
fi
  

echo
echo
echo "Executable 'kokkos_example' is in the make_build_dir directory"

