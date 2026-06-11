#!/bin/bash
#$ -N TEST
#$ -cwd  
#$ -l h_rt=24:00:00 
#$ -l h_vmem=10G
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/CR_array_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/CR_array_output.txt
#$ -M schandr3@ed.ac.uk
#$ -t 1-12

. /etc/profile.d/modules.sh

cd /exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/11944/


if [ ! -d "/exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/11944/test" ]
then
	mkdir /exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/11944/test
fi

#cd /exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/11944/test

input=()
for folder in *11944MAPool01-S__*; do
	input+=($folder)
done	
#echo ${input[@]} > TEST_input.txt

inputfilename="${input[$SGE_TASK_ID - 1]}"

#echo $inputfilename >> /exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/11944/test/arraytest.txt

cd /exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/11944/test

FQ_PATH="/exports/eddie/scratch/schandr3/Scripts_data/Nneka_scRNAseq/11944/${inputfilename}"
echo $FQ_PATH > ${inputfilename}_FQ_PATH.txt

CR_NAME="${inputfilename}_CellRanger"
echo $CR_NAME > ${inputfilename}_CR_NAME.txt


