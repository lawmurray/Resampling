#!/bin/sh

export KMP_AFFINITY=verbose,compact
export CONFIG_OPTS="--nthreads 8"
export OUTPUT_SUFFIX="cpu-with-copy"

./run.sh
