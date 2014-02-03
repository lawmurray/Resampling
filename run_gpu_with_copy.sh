#!/bin/sh

export CONFIG_OPTS="--nthreads 1 --disable-assert --enable-single --enable-cuda --with-copy"
export OUTPUT_SUFFIX="gpu-with-copy"

./run.sh
