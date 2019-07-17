#!/bin/bash -l

#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

#SBATCH --time=00:01:00


#SBATCH --job-name=test_submission
#SBATCH --output=openmp_test.out
#SBATCH --error=openmp_test.err

export OMP_NUM_THREADS=8


### openmp executable
./1.hello_world.exec

