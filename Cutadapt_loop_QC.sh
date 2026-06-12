#!/bin/bash
#$ -N Cutadapt_QC
#$ -l h_rt=24:00:00 
#$ -l h_vmem=20G
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/raw_data/Cutadapt_QC_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/raw_data/Cutadapt_QC_output.txt
#$ -M schandr3@ed.ac.uk

. /etc/profile.d/modules.sh
module load igmm/apps/cutadapt/4.6
module load roslin/fastqc/0.11.7
module load python/3.11.4

cd /exports/eddie/scratch/schandr3/Scripts_data/raw_data/
adapters="file:/exports/eddie/scratch/schandr3/Scripts_data/NexteraPE-PE.fa"

if [ ! -d "/exports/eddie/scratch/schandr3/Scripts_data/raw_data/trimmed_reads" ]
then
	mkdir /exports/eddie/scratch/schandr3/Scripts_data/raw_data/trimmed_reads
fi

for folder in *CS1*/; do #*_set*/; do 
	cd /exports/eddie/scratch/schandr3/Scripts_data/raw_data/${folder%/}
	#mkdir trimmed_${folder%/}
	out_path=/exports/eddie/scratch/schandr3/Scripts_data/raw_data/trimmed_reads
	for i in *_1.fq.gz; do
		SAMPLE=$(echo ${i} | sed "s/_1\.fq\.gz//")   
		cutadapt -a $adapters -A $adapters -j 1 -e 0.005 -O 7 -m 33 -q 10 -o ${out_path}/trimmed_${folder%/}/${SAMPLE}_cut_1.fq.gz -p ${out_path}/trimmed_${folder%/}/${SAMPLE}_cut_2.fq.gz ${SAMPLE}_1.fq.gz ${SAMPLE}_2.fq.gz
	done	
	
	cd ${out_path}/trimmed_${folder%/}
	#cd /exports/eddie/scratch/schandr3/Scripts_data/raw_data/trimmed_${folder%/}
	fastqc *.fq.gz
	/exports/eddie3_homes_local/schandr3/.local/bin/multiqc .
done




