#!/bin/bash
#$ -N fastQCScript_hold_jid
#$ -hold_jid stagein
#$ -l h_rt=48:00:00 
#$ -l h_vmem=20G
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/10X_CS13/fastQCScript_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/10X_CS13/fastQCScript_output.txt
#$ -M schandr3@ed.ac.uk

. /etc/profile.d/modules.sh
module load roslin/fastqc/0.11.7
module load python/3.11.4

cd /exports/eddie/scratch/schandr3/Scripts_data/10X_CS13/


for folder in 11667MAPool01-N*/; do 
	cd /exports/eddie/scratch/schandr3/Scripts_data/10X_CS13/${folder%/}/  #trimmed_${folder%/}
	fastqc *.fastq.gz
	/exports/eddie3_homes_local/schandr3/.local/bin/multiqc .
	
done




