#!/bin/bash
#$ -N genome_script
#$ -l h_rt=48:00:00 
#$ -l h_vmem=40G
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/STAR/rnaseq_STAR_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/STAR/rnaseq_STAR_output.txt
. /etc/profile.d/modules.sh

module load igmm/apps/STAR/2.7.8a

cd /exports/eddie/scratch/schandr3/Scripts_data/STAR/

STAR --runThreadN 16 \
--runMode genomeGenerate \
--genomeDir GRCh38_ens111_index \
--genomeFastaFiles /exports/eddie/scratch/schandr3/Scripts_data/STAR/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
--sjdbGTFfile /exports/eddie/scratch/schandr3/Scripts_data/STAR/Homo_sapiens.GRCh38.111.gtf \
--sjdbOverhang 74  #max(read length)-1



