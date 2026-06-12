#!/bin/bash
#$ -l h_rt=48:00:00
#$ -cwd
#$ -N fastqdump
#$ -l h_vmem=8G
#$ -e fastqdump_error.txt
#$ -o fastqdump_output.txt

. /etc/profile.d/modules.sh

module load igmm/apps/sratoolkit/3.0.0
cd /exports/eddie/scratch/schandr3/GSE151876_Edie_SCdata/Data_GSE151876/trunk_ao

fastq-dump --split-files --gzip SRR11934374 SRR11934375