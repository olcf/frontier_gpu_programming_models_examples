#!/bin/bash

#SBATCH -A stf007uanofn
#SBATCH -p batch
#SBATCH -t 00:05:00
#SBATCH -N 1
#SBATCH --export=NONE

module load DefApps
module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
module load openblas

#srun -N1 -n1 -c4 --gpus-per-task=1 --gpu_bind=closest ./make_build_dir/cpu_gpu_dgemm
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/cpu_gpu_dgemm
