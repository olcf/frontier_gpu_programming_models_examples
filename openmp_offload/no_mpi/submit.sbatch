#!/bin/bash

#SBATCH -A stf007uanofn
#SBATCH -p batch
#SBATCH -t 00:35:00
#SBATCH -N 1


# If using cray environment
module load PrgEnv-cray
module load amd-mixed
module load craype-accel-amd-gfx90a

# If using amd environment
#module load PrgEnv-amd
#module load craype-accel-amd-gfx90a

export OMP_PROC_BIND=spread
export OMP_PLACES=threads

export OMP_NUM_THREADS=4
# Uncomment below to use rocprof to validate if the code is running on gpu
export ROCPROF=$ROCM_PATH/bin/rocprof

#srun -N1 -n1 -c4 --gpus-per-task=4 --gpu-bind=closest $ROCPROF ./cmake_build_dir/jacobi 10000 100
srun -N1 -n1 -c4 --gpus-per-task=4 --gpu-bind=closest $ROCPROF ./make_build_dir/jacobi 10000 100 

