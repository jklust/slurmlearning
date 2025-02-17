make_run_file() {
cat > $1.sh <<%EOF%
#!/bin/bash
#SBATCH --job-name=$1
#SBATCH --output="out.txt"
#SBATCH --error="err.txt"
#SBATCH --time=00:00:30
#SBATCH --mem=150M
#SBATCH --nodes $2
#SBATCH --ntasks-per-node $3
#SBATCH --cpus-per-task $4

make
srun $SLURM_NTASKS ./main.exe
%EOF%
}

name=mult_node
nodes=2
nproc=2
ncpus=2
export OMP_NUM_THREADS=${ncpus}

make_run_file ${name} ${nodes} ${nproc} ${ncpus}
sbatch ${name}.sh
