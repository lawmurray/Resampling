#!/bin/sh

export KMP_AFFINITY="compact"
export CONFIG_OPTS="--with-cuda"
export OUTPUT_SUFFIX="gpu"
export COMMON_OPTS="--Zs 9 --Ps 19 --reps 256 --without-sort --disable-assert --enable-single --enable-cuda --nthreads 8"

# run Metropolis resampler for different numbers of steps
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c1-$OUTPUT_SUFFIX.nc -C 1
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c2-$OUTPUT_SUFFIX.nc -C 2
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c4-$OUTPUT_SUFFIX.nc -C 4
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c8-$OUTPUT_SUFFIX.nc -C 8
