# regenie-apptainer
Recipe for building an Apptainer to run [**regenie**](https://rgcgithub.github.io/regenie/).

&ldquo;**regenie** is a C++ program for whole genome regression modelling of large genome-wide association studies.&rdquo;

## Instructions

1. Run the `predownload.sh` script to download a base Ubuntu Jammy SIF, and build a base Ubuntu Jammy with Intel OneAPI MKL 2025.1. This is to avoid repeated downloads.
2. Run the `buildregenie.sh` script.

NOTE both scripts are actually Slurm job scripts.
