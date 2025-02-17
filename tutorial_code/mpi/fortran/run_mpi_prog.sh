#!/usr/bin/env bash
make_run_file() {
cat > $1.sh <<%EOF%
#!/bin/bash
#SBATCH --job-name=$1
#SBATCH --output="out.txt"
#SBATCH --error="err.txt"
#SBATCH --time=00:00:30
#SBATCH --mem=150M
#SBATCH --ntasks-per-node=$2

make
srun ./main.exe
%EOF%
}

name=mpi_fortran
ncpus=2

make_run_file ${name} ${ncpus}
sbatch ${name}.sh
