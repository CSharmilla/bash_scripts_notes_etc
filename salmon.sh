#!/bin/bash
#$ -N SalmonScript
#$ -l h_rt=48:00:00 
#$ -l h_vmem=30G
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/CD41/SalmonScript_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/CD41/SalmonScript_output.txt
#$ -M schandr3@ed.ac.uk

. /etc/profile.d/modules.sh
#module load igmm/apps/salmon/1.3.0
module load anaconda
conda activate salmon2

cd /exports/eddie/scratch/schandr3/Scripts_data/CD41/

salmon_index="/exports/eddie/scratch/schandr3/Scripts_data/salmon_index"

for folder in *_set*/; do 
	cd /exports/eddie/scratch/schandr3/Scripts_data/CD41/${folder%/}/trimmed_${folder%/}
	mkdir -p quant_${folder%/} #-p create folder if it doesnt exist
	for i in *_1.fastq.gz; do
		SAMPLE=$(echo ${i} | sed "s/_1\.fastq\.gz//")   
		salmon quant -l A -i $salmon_index -1 ${SAMPLE}_1.fastq.gz -2 ${SAMPLE}_2.fastq.gz -p 16 -o quant_${folder%/}/quant_${SAMPLE} --validateMappings
	# A libtype (1) is automatic
	done	
done
