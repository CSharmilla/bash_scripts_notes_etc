#!/bin/bash
#$ -N CR_array
#$ -cwd  
#$ -l h_rt=48:00:00 
#$ -l h_vmem=12G
#$ -pe sharedmem 16
#$ -R y
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/Nneka/CR_array_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/Nneka/CR_array_output.txt
#$ -M schandr3@ed.ac.uk
#$ -t 1-12

. /etc/profile.d/modules.sh

cd /exports/eddie/scratch/schandr3/Scripts_data/Nneka/11944/

module load igmm/apps/cellranger/7.2.0
module load igmm/apps/STAR/2.7.8a

REF_PATH=/exports/eddie/scratch/schandr3/Scripts_data/refdata-gex-GRCh38-2024-A

input=()
for folder in *11944MAPool01-S__*; do
	input+=($folder)
done
	
#echo ${input[@]}


inputfilename="${input[$SGE_TASK_ID - 1]}"


if [ ! -d "/exports/eddie/scratch/schandr3/Scripts_data/Nneka/11944/CR_output" ]
then
	mkdir /exports/eddie/scratch/schandr3/Scripts_data/Nneka/11944/CR_output
fi


cd /exports/eddie/scratch/schandr3/Scripts_data/Nneka/11944/CR_output

FQ_PATH="/exports/eddie/scratch/schandr3/Scripts_data/Nneka/11944/${inputfilename}"

CR_NAME=${inputfilename}_CellRanger

cellranger count --id=$CR_NAME \
	--transcriptome=$REF_PATH \
	--fastqs=$FQ_PATH \
	--localcores=16 \
	--localmem=172
		



