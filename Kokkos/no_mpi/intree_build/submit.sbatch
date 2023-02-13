#!/bin/bash

#SBATCH -A stf007uanofn
#SBATCH -p batch
#SBATCH -t 00:05:00
#SBATCH -N 1
#SBATCH --export=NONE

module load DefApps
module load PrgEnv-cray
module load rocm/5.1.0

export OMP_PROC_BIND=spread
export OMP_PLACES=threads

export OMP_NUM_THREADS=4
#srun -N1 -n1 -c4 --gpus-per-task=1 --gpu_bind=closest ./make_build_dir/kokkos_example
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/kokkos_example
