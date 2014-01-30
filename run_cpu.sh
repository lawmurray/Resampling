#!/bin/sh

export KMP_AFFINITY=verbose,compact

CONFIG_OPTS="--nthreads 8 --disable-assert --enable-single --enable-sse"
OUTPUT_SUFFIX="cpu"

source run.sh
