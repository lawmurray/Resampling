#!/bin/sh

export KMP_AFFINITY=verbose,compact

COMMON_OPTS="--Zs 9 --Ps 17 --reps 500 --disable-sort --threads 8 --disable-assert --enable-single --enable-mkl "

bi test_resampler $COMMON_OPTS --resampler multinomial --output-file results/multinomial-cpu.nc
bi test_resampler $COMMON_OPTS --resampler stratified --output-file results/stratified-cpu.nc
bi test_resampler $COMMON_OPTS --resampler systematic --output-file results/systematic-cpu.nc
bi test_resampler $COMMON_OPTS --resampler metropolis --output-file results/metropolis-cpu.nc
bi test_resampler $COMMON_OPTS --resampler rejection --output-file results/rejection-cpu.nc
bi test_resampler $COMMON_OPTS --resampler sort --output-file results/sort-cpu.nc
bi test_resampler $COMMON_OPTS --resampler ess --output-file results/ess-cpu.nc
