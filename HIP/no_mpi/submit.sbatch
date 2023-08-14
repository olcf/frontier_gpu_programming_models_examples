#!/bin/bash

#SBATCH -A stf007uanofn
#SBATCH -p batch
#SBATCH -t 00:05:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -G 1

# If you're using PrgEnv-cray
#module load PrgEnv-cray
#module load craype-accel-amd-gfx90a
#module load amd-mixed 

# If you're using PrgEnv-amd
module load PrgEnv-amd
module load craype-accel-amd-gfx90a

#srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./make_build_dir/vAdd_hip
srun -N1 -n1 -c4 --gpus-per-task=1 --gpu-bind=closest ./cmake_build_dir/vAdd_hip
