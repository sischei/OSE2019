#!/bin/sh
#BATCH --job-name=job1
#SBATCH --output=job1.out
#SBATCH --error=job1.err
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=8
 
#module load mpi4py/1.3+python-2.7-2015q2
#mpi4py/1.3+intelmpi-4.0
module load Anaconda2

mpirun python bcast.py

