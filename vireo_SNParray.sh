#!/bin/bash
#$ -N DPFS_vireo
#$ -cwd  
#$ -l h_rt=48:00:00 
#$ -l h_vmem=30G
#$ -e DPFS_vireo_error.txt
#$ -o DPFS_vireo_output.txt
#$ -M schandr3@ed.ac.uk
#$ -m beas

. /etc/profile.d/modules.sh

cd /exports/eddie/scratch/schandr3/Scripts_data/DPFS/

module load anaconda
conda activate vireo

# For Vireo you should only have the donors that are in this pool in the vcf file

vireo --cellData /exports/eddie/scratch/schandr3/cellsnplite_out_new/ \
--donorFile donor_subset.vcf \
--nDonor 16 \
-o /exports/eddie/scratch/schandr3/vireo/ \
-p 22 \
--genoTag GT
