#!/bin/bash
#$ -N CutadaptScript
#$ -l h_rt=48:00:00 
#$ -l h_vmem=20G
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/CD41/CutadaptScript_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/CD41/CutadaptScript_output.txt
#$ -M schandr3@ed.ac.uk

. /etc/profile.d/modules.sh
module load igmm/apps/cutadapt/4.6

cd /exports/eddie/scratch/schandr3/Scripts_data/CD41/
adapters="file:/exports/eddie/scratch/schandr3/Scripts_data/NexteraPE.fa"

for folder in *AGM_GFPneg_set_A*/; do #*_set*/; do 
	cd /exports/eddie/scratch/schandr3/Scripts_data/CD41/${folder%/}
	mkdir trimmed_${folder%/}
	for i in *_1.fastq.gz; do
		SAMPLE=$(echo ${i} | sed "s/_1\.fastq\.gz//")   
		cutadapt -a $adapters -A $adapters -j 1 -e 0.005 -O 7 -m 33 -o trimmed_${folder%/}/${SAMPLE}_cut_1.fastq.gz -p trimmed_${folder%/}/${SAMPLE}_cut_2.fastq.gz ${SAMPLE}_1.fastq.gz ${SAMPLE}_2.fastq.gz
	done	
done




