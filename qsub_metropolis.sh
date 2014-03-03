#!/bin/sh

source ~/init.sh
cd $PBS_O_WORKDIR
SEED=$PBS_ARRAYID

export KMP_AFFINITY="compact"
export CONFIG_OPTS="--seed $SEED --with-cuda"
export OUTPUT_SUFFIX="gpu-$SEED"
export COMMON_OPTS="--Zs 9 --Ps 19 --reps 256 --without-sort --disable-assert --enable-single --enable-cuda --nthreads 8"

libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c1-$OUTPUT_SUFFIX.nc -C 1
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c2-$OUTPUT_SUFFIX.nc -C 2
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c4-$OUTPUT_SUFFIX.nc -C 4
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c8-$OUTPUT_SUFFIX.nc -C 8
