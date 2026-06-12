#!/bin/bash
#$ -N STAR_script
#$ -l h_rt=48:00:00 
#$ -l h_vmem=40G
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/GEO_submission_June20/HE_populations_RNASeq/second_trimmed_HE_populations_RNASeq/STAR_aligned/rnaseq_STAR_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/GEO_submission_June20/HE_populations_RNASeq/second_trimmed_HE_populations_RNASeq/STAR_aligned/rnaseq_STAR_output.txt
. /etc/profile.d/modules.sh

module load igmm/apps/STAR/2.7.8a

cd /exports/eddie/scratch/schandr3/Scripts_data/GEO_submission_June20/HE_populations_RNASeq/second_trimmed_HE_populations_RNASeq/

index=/exports/eddie/scratch/schandr3/Scripts_data/STAR/GRCh38_ens111_index

for i in *_1.fastq.gz; do
	SAMPLE=$(echo ${i} | sed "s/_1\.fastq\.gz//")
	
	fq1=/exports/eddie/scratch/schandr3/Scripts_data/GEO_submission_June20/HE_populations_RNASeq/second_trimmed_HE_populations_RNASeq/${SAMPLE}_1.fastq.gz
	
	fq2=/exports/eddie/scratch/schandr3/Scripts_data/GEO_submission_June20/HE_populations_RNASeq/second_trimmed_HE_populations_RNASeq/${SAMPLE}_2.fastq.gz
	
	out=/exports/eddie/scratch/schandr3/Scripts_data/GEO_submission_June20/HE_populations_RNASeq/second_trimmed_HE_populations_RNASeq/STAR_aligned/${SAMPLE}_

	STAR --genomeDir $index \
	--runThreadN 16 \
	--readFilesIn $fq1 $fq2 \
	--outFileNamePrefix $out \
	--outSAMtype BAM SortedByCoordinate \
	--readFilesCommand gunzip -c	
done


