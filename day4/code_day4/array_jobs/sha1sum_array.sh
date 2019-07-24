#!/bin/bash

#SBATCH --job-name=sha1sum-array
#SBATCH --time=5:00
#SBATCH --nodes=1
#SBATCH --output example-array-%a.out
#SBATCH --array=1-100%20  

if [ -z "${SLURM_ARRAY_TASK_ID}" ]
then
    echo 1>&2 "Error: not running as a job array."
    exit 1
fi

echo "Array index: ${SLURM_ARRAY_TASK_ID}"

data_file="input-data-${SLURM_ARRAY_TASK_ID}"
sha1sum $data_file | tee "${data_file}.sha1"

