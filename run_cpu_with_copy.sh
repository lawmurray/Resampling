#!/bin/sh

export KMP_AFFINITY=verbose,compact

CONFIG_OPTS="--nthreads 8 --disable-assert --enable-single --enable-sse --with-copy"
OUTPUT_SUFFIX="cpu-with-copy"

source run.sh
