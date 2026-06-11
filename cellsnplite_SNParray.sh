#!/bin/bash
#$ -N DPFS_cellsnplite
#$ -cwd  
#$ -l h_rt=48:00:00 
#$ -l h_vmem=30G
#$ -e /exports/eddie/scratch/schandr3/DPFS_cellsnplite_error.txt
#$ -o /exports/eddie/scratch/schandr3/DPFS_cellsnplite_output.txt
#$ -M schandr3@ed.ac.uk

. /etc/profile.d/modules.sh

cd /exports/eddie/scratch/schandr3/

module load anaconda
conda activate cellsnplite2

cellsnp-lite -s /exports/eddie/scratch/schandr3/DPFS_27990_CellRanger/outs/possorted_genome_bam.bam \
-b /exports/eddie/scratch/schandr3/DPFS_27990_CellRanger/outs/filtered_feature_bc_matrix/barcodes.tsv.gz \
--gzip \
-O /exports/eddie/scratch/schandr3/cellsnplite_out_new/ \
-R /exports/eddie/scratch/schandr3/GTC2VCF_file.vcf \
-p 22 --minMAF 0.1 --minCOUNT 20
