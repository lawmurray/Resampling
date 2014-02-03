#!/bin/sh

export CONFIG_OPTS="--nthreads 1 --disable-assert --enable-single --enable-cuda"
export OUTPUT_SUFFIX="gpu"

./run.sh
