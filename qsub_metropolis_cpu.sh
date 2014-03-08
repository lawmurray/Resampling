#!/bin/sh
#PBS -l walltime=08:00:00,nodes=1:ppn=16,vmem=32gb
#PBS -j oe

source ~/init.sh
cd $PBS_O_WORKDIR
SEED=$PBS_ARRAYID

export KMP_AFFINITY="compact"
export CONFIG_OPTS="--seed $SEED"
export OUTPUT_SUFFIX="cpu-$SEED"

./run_metropolis.sh
