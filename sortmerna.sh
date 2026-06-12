#!/bin/bash
#$ -N sortmerna
#$ -l h_rt=48:00:00 
#$ -l h_vmem=16G
#$ -pe sharedmem 4
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/sortmerna_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/sortmerna_output.txt
#$ -m beas
#$ -M schandr3@ed.ac.uk

. /etc/profile.d/modules.sh
module load anaconda
conda activate sortmerna

cd /exports/eddie/scratch/schandr3/Scripts_data/trimmed_LCMSeq_RNASeq/

ref1="/exports/eddie/scratch/schandr3/Scripts_data/sortmerna_ref/smr_v4.3_sensitive_db_rfam_seeds.fasta"
ref2="/exports/eddie/scratch/schandr3/Scripts_data/sortmerna_ref/smr_v4.3_sensitive_db.fasta"
ref3="/exports/eddie/scratch/schandr3/Scripts_data/sortmerna_ref/smr_v4.3_fast_db.fasta"
ref4="/exports/eddie/scratch/schandr3/Scripts_data/sortmerna_ref/smr_v4.3_default_db.fasta" # recommended

mkdir -p sortmerna #-p create folder if it doesnt exist


for i in *_1.fastq.gz; do
	SAMPLE=$(echo ${i} | sed "s/_1\.fastq\.gz//")   
	sortmerna --ref $ref4 --reads ${SAMPLE}_1.fastq.gz --reads ${SAMPLE}_2.fastq.gz --workdir sortmerna/${SAMPLE} --sam --fastx --out2 --other sortmerna/${SAMPLE}/other/other_${SAMPLE} --aligned sortmerna/${SAMPLE}/aligned/aligned_${SAMPLE}
done	

