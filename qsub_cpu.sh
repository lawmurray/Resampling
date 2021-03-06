#!/bin/sh
#PBS -l walltime=24:00:00,nodes=1:ppn=16:gpus=1,vmem=64gb
#PBS -j oe

source ~/init.sh
cd $PBS_O_WORKDIR
SEED=$PBS_ARRAYID

export KMP_AFFINITY=compact
export CONFIG_OPTS="--seed $SEED"
export OUTPUT_SUFFIX="cpu-$SEED"

./run.sh
