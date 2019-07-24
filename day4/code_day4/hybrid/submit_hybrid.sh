#!/bin/bash
#SBATCH -N
#SBATCH --tasks-per-node=2
#SBATCH -c 8

export OMP_NUM_THREADS=8
module load openmpi

### hybrid executable
srun -c 8 ./1.hello_world_mpi.exec

