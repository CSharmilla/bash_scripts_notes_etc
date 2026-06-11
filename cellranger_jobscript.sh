#!/bin/bash
#$ -N CellRangerScript
#$ -cwd  
#$ -l h_rt=48:00:00 
#$ -l h_vmem=20G
#$ -pe sharedmem 8
#$ -e CellRangerScript_error.txt
#$ -o CellRangerScript_output.txt
#$ -M schandr3@ed.ac.uk


. /etc/profile.d/modules.sh
module load igmm/apps/cellranger/7.2.0
module load roslin/star/2.7.10a

cd /exports/eddie/scratch/schandr3/DPFS_CR

REF_PATH=/exports/eddie/scratch/schandr3/DPFS_CR/refdata-gex-GRCh38-2024-A
FQ_PATH=/exports/eddie/scratch/schandr3/27990_backup_iTPA
CR_NAME=trunk_ao_CellRanger

cellranger count --id=$CR_NAME \
	--transcriptome=$REF_PATH \
	--fastqs=$FQ_PATH \
	--sample=11387MApool01__CS16_I_Aorta_S11_ \



# a=$(find ~+ -type f -name "11387MApool01__CS16_I_Aorta_S11_*") the tilde gives the full path
