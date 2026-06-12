#!/bin/bash
#$ -N SalmonScript
#$ -l h_rt=48:00:00 
#$ -l h_vmem=60G
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/SalmonIndex_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/SalmonIndex_output.txt
#$ -M schandr3@ed.ac.uk

. /etc/profile.d/modules.sh
module load igmm/apps/salmon/1.3.0
 
cd /exports/eddie/scratch/schandr3/Scripts_data/

salmon index -t gentrome.fa.gz -d decoys.txt -p 16 -i salmon_index --gencode --keepDuplicates