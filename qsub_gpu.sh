#!/bin/sh
#PBS -l walltime=08:00:00,nodes=1:ppn=16,vmem=32gb
#PBS -j oe

source ~/init.sh
cd $PBS_O_WORKDIR

./run_gpu.sh
