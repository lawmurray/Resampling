#!/bin/sh
#PBS -l walltime=16:00:00,nodes=1:ppn=16,vmem=32gb
#PBS -j oe

source ~/init.sh
cd $PBS_O_WORKDIR
SEED=$PBS_ARRAYID

export KMP_AFFINITY=compact
export CONFIG_OPTS="--seed $SEED --with-cuda"
export OUTPUT_SUFFIX="gpu-$SEED"

./run.sh
