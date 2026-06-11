#!/bin/bash
#$ -N lcm_stagein 
#$ -hold_jid CS13_CR_array
#$ -cwd
#$ -q staging
#$ -l h_rt=12:00:00 
#$ -e /exports/eddie/scratch/schandr3/Scripts_data/stagein_error.txt
#$ -o /exports/eddie/scratch/schandr3/Scripts_data/stagein_output.txt
#$ -r yes
#$ -notify
trap 'exit 99' sigusr1 sigusr2 sigterm

# Source and destination directories

SOURCE=/exports/eddie/scratch/schandr3/Scripts_data/10X_CS13
DESTINATION=/exports/csce/datastore/biology/groups/medvinsky/Sharmilla/
# Perform copy with rsync
# Note: do not use -p or -a (implies -p) as this can break file ACLs at the destination
rsync -rl ${SOURCE} ${DESTINATION}
 

