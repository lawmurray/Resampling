#!/bin/sh

CONFIG_OPTS="--nthreads 1 --with-cuda"
COMMON_OPTS="--Zs 7 --Ps 15 --reps 256 --without-sort --seed 0 --disable-assert --enable-single --enable-cuda"

libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c1.nc -C 1
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c2.nc -C 2
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c4.nc -C 4
libbi test_resampler $CONFIG_OPTS $COMMON_OPTS --resampler metropolis --output-file results/metropolis-c8.nc -C 8
