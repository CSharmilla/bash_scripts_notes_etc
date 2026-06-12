#!/bin/bash
#$ -N umi_tools
#$ -l h_rt=48:00:00 
#$ -l h_vmem=16G
#$ -pe sharedmem 4
#$ -cwd
#$ -e /exports/eddie/scratch/schandr3/Zeng_data/umi_tools_error.txt
#$ -o /exports/eddie/scratch/schandr3/Zeng_data/umi_tools_output.txt
#$ -m beas
#$ -M schandr3@ed.ac.uk

. /etc/profile.d/modules.sh

module load anaconda/2024.02

#module load roslin/multiqc/1.30

conda activate UMItools

cd /exports/eddie/scratch/schandr3/Zeng_data/

mkdir -p umi_tools_out

#gzip *.fastq

zeng_barcodes="/exports/eddie/scratch/schandr3/Zeng_data/zeng_barcodes.txt"

for i in *_2.fastq.gz; do
	SAMPLE=$(echo ${i} | sed "s/_2\.fastq.gz//")  
	
	umi_tools extract \
	  --extract-method=regex \
	  --bc-pattern='(?P<primer_1>TCAGACGTGTGCTCTTCCGATCT)(?P<sample_1>[ACGT]{8})(?P<umi_1>[ACGT]{8})' \
	  --stdin=$i \
	  --stdout=umi_tools_out/${SAMPLE}_2_extracted.fastq.gz \
	  --read2-in=${SAMPLE}_1.fastq.gz \
	  --read2-out=umi_tools_out/${SAMPLE}_1_extracted.fastq.gz 
	  # --whitelist=$zeng_barcodes
	
	# umi_tools whitelist --stdin i \
						# --bc-pattern=NNNNNNNN \
						# --set-cell-number=96 \
						# --log2stderr > umi_tools_out/${SAMPLE}_whitelist.txt

	
	#cutadapt -a $adapters -A $adapters -j 1 -e 0.005 -O 7 -m 33 -q 10 -o trimmed_Zeng_data/${SAMPLE}_cut_1.fastq -p trimmed_Zeng_data/${SAMPLE}_cut_2.fastq ${SAMPLE}_1.fastq ${SAMPLE}_2.fastq
done	

#cd /exports/eddie/scratch/schandr3/Zeng_data/trimmed_Zeng_data
#fastqc *.fastq
#multiqc .
#/exports/eddie3_homes_local/schandr3/.local/bin/multiqc .
# '(?P<discard_1>.{23})(?P<umi_1>.{8})' \
#.{23}XXXXXXXXNNNNNNNN
#'(?P<discard_1>.{23})(?P<cell_1>.{8})(?P<umi_1>.{8})' \
# cDNAs were synthesized using sample-specific 25-nt oligo-dT primer containing 8-nt barcode (TCAGACGTGTGCTCTTCCGATCT-XXXXXXXX-DDDDDDDD-T25, X representing sample-specific barcode while D standing for unique molecular identifiers (UMI)