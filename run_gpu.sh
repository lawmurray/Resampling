#!/bin/sh

COMMON_OPTS="--Zs 9 --Ps 17 --reps 500 --disable-sort --threads 1 --disable-assert --enable-cuda --enable-single --enable-mkl"

#bi test_resampler $COMMON_OPTS --resampler multinomial --output-file results/multinomial-gpu.nc
#bi test_resampler $COMMON_OPTS --resampler stratified --output-file results/stratified-gpu.nc
#bi test_resampler $COMMON_OPTS --resampler systematic --output-file results/systematic-gpu.nc
#bi test_resampler $COMMON_OPTS --resampler metropolis --output-file results/metropolis-gpu.nc
#bi test_resampler $COMMON_OPTS --resampler rejection --output-file results/rejection-gpu.nc
bi test_resampler $COMMON_OPTS --resampler sort --output-file results/sort-gpu.nc
bi test_resampler $COMMON_OPTS --resampler ess --output-file results/ess-gpu.nc
