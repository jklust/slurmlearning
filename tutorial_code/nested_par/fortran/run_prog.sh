make_run_file() {
cat > $1.sh <<%EOF%
#!/bin/bash
#SBATCH --job-name=$1
#SBATCH --output="out.txt"
#SBATCH --error="err.txt"
#SBATCH --time=00:00:30
#SBATCH --mem=150M
#SBATCH --ntasks-per-node $2
#SBATCH --cpus-per-task $3

make
srun ./main.exe
%EOF%
}

name=nested_fortran
nproc=2
ncpus=2
export OMP_NUM_THREADS=${ncpus}

make_run_file ${name} ${nproc} ${ncpus}
sbatch ${name}.sh
