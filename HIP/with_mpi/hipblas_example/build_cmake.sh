#!/bin/bash



mkdir -p cmake_build_dir && cd cmake_build_dir 
rm -rf ./*



# If you're using PrgEnv-cray
module load PrgEnv-cray
module load amd-mixed

# If you're using PrgEnv-amd
#module load PrgEnv-amd


module load openblas
module load cmake/3.23.2
cmake -DCMAKE_HIP_ARCHITECTURES="gfx90a" ..
VERBOSE=1 make

echo 
echo
if [[ -f "$(pwd)/cpu_gpu_dgemm" ]]; then
echo "executable 'cpu_gpu_dgemm' built in cmake_build_dir"
fi
