#!/bin/bash
#SBATCH --partition=all
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2G
#SBATCH --time=2:30:00
#SBATCH --job-name=buildregenie
#SBATCH --output=buildregenie-%j.out

# Final build of the SIF is slow. Test build took 1hr 20min.

# Do all work in local storage and copy it back out

cp ubuntu_oneapi.sif ${TMP}
cp regenie.def ${TMP}
cp bgen-1.1.7.tgz ${TMP}
cp htslib-1.18.tar.bz2 ${TMP}
cp intel_key.PUB ${TMP}
cp regenie-4.1.tar.gz ${TMP}
cd ${TMP}

apptainer build regenie.sif regenie.def

[[ -f regenie.sif ]] && cp -f regenie.sif ${SLURM_SUBMIT_DIR}
