#!/bin/sh

export CONFIG_OPTS="--nthreads 8 --with-cuda"
export OUTPUT_SUFFIX="gpu"

./run.sh
