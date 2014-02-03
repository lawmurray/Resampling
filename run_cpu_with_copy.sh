#!/bin/sh

export KMP_AFFINITY=verbose,compact
export CONFIG_OPTS="--nthreads 8 --disable-assert --enable-single --enable-sse --with-copy"
export OUTPUT_SUFFIX="cpu-with-copy"

./run.sh
