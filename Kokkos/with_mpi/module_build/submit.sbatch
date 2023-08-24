#!/bin/bash

#SBATCH -A stf007uanofn
#SBATCH -p batch
#SBATCH -t 00:05:00
#SBATCH -N 1

module load PrgEnv-cray
module load amd-mixed

export OMP_PROC_BIND=spread
export OMP_PLACES=threads

export OMP_NUM_THREADS=4
srun -N1 -n4 -c4 --gpus-per-task=1 --gpu-bind=closest rocprof -d results ./cmake_build_dir/kokkos_example
