#!/bin/bash

# Update the options below and run with ./build_cmake.sh

# Options you can adjust

PRGENV="PrgEnv-cray" # can be: PrgEnv-cray | PrgEnv-gnu | PrgEnv-amd
CXX_COMPILER="hipcc" # can be: hipcc | CC . hipcc for GPU backend. CC for CPU backend only.
DEVICES="HIP,Serial" # can be: HIP,Serial | OpenMP,Serial . HIP,Serial for GPU backend. OpenMP,Serial for CPU backend.
ARCH="ZEN3,VEGA90A"        



export CRAYPE_LINK_TYPE=dynamic

mkdir -p make_build_dir && cd make_build_dir
rm -rf ./*

cp ../Makefile ../kokkos_example.cpp .

module load ${PRGENV}
if [[ "$PRGENV" != PrgEnv-amd ]]; then
module load amd-mixed 
fi

if [[ ${CXX_COMPILER} == "CC" ]]; then
  make KOKKOS_DEVICES=${DEVICES} CXX=${CXX_COMPILER} KOKKOS_ARCH=${ARCH}
elif [[ ${CXX_COMPILER} == "hipcc" ]]; then
  make KOKKOS_DEVICES=${DEVICES} CXX=${CXX_COMPILER} KOKKOS_ARCH=${ARCH} \
       CXXFLAGS="-I${MPICH_DIR}/include" LINKFLAGS="-L${MPICH_DIR}/lib -lmpi ${CRAY_XPMEM_POST_LINK_OPTS} -lxpmem ${PE_MPICH_GTL_DIR_amd_gfx90a} ${PE_MPICH_GTL_LIBS_amd_gfx90a}"
fi
  

echo
echo
echo "Executable 'kokkos_example' is in the make_build_dir directory"

