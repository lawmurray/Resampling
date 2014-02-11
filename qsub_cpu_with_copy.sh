#!/bin/sh
#PBS -l walltime=24:00:00,nodes=1:ppn=16,vmem=32gb
#PBS -j oe

source ~/init.sh
cd $PBS_O_WORKDIR
SEED=$PBS_ARRAYID

export KMP_AFFINITY=compact
export CONFIG_OPTS="--seed $SEED --with-copy"
export OUTPUT_SUFFIX="cpu-with-copy-$SEED"

./run.sh
