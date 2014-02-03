#!/bin/sh

export KMP_AFFINITY=verbose,compact
export CONFIG_OPTS="--nthreads 8 --disable-assert --enable-single --enable-sse"
export OUTPUT_SUFFIX="cpu"

./run.sh
