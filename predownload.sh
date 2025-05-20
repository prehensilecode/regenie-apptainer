#!/bin/bash
#SBATCH --partition=short
#SBATCH --mem-per-cpu=32G
#SBATCH --time=2:30:00
#SBATCH --job-name=predownload
#SBATCH --output=predownload-%j.out

# pre-download stuff for the regenie apptainer,
# and build the base image with Intel OneAPI

# NOTE wget -c will not re-download existing file
BGEN_VERSION=1.1.7
HTSLIB_VERSION=1.18
REGENIE_VERSION=4.1

# download ubuntu jammy SIF if not already downloaded

[[ ! -f ubuntu_jammy.sif ]] && apptainer pull docker://ubuntu:jammy

# NOTE wget -c will not re-download existing file

wget -c https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB -O intel_key.PUB
wget -c https://code.enkre.net/bgen/tarball/release/v${BGEN_VERSION} -O bgen-${BGEN_VERSION}.tgz
wget -c https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2
wget -c https://github.com/rgcgithub/regenie/archive/refs/tags/v${REGENIE_VERSION}.tar.gz -O regenie-${REGENIE_VERSION}.tar.gz

cp ubuntu_jammy.sif ${TMP}
cp ubuntu_oneapi.def ${TMP}
cp intel_key.PUB ${TMP}
cd ${TMP}

apptainer build ubuntu_oneapi.sif ubuntu_oneapi.def

[[ -f ubuntu_oneapi.sif ]] && cp -f ubuntu_oneapi.sif ${SLURM_SUBMIT_DIR}
