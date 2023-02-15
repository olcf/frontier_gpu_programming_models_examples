#!/bin/bash

#SBATCH -A stf007uanofn
#SBATCH -p batch
#SBATCH -t 00:15:00
#SBATCH -N 1

module purge
module load DefApps
module load PrgEnv-cray # or PrgEnv-amd depending on what you used to compile
module load craype-accel-amd-gfx90a
module load rocm

export OMP_PROC_BIND=spread
export OMP_PLACES=threads

export OMP_NUM_THREADS=4
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/jacobi 100 100
#srun -N1 -n4 -c4 --gpus-per-task=1 --gpu-bind=closest ./make_build_dir/jacobi 100 100

