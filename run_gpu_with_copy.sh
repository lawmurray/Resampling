#!/bin/sh

export KMP_AFFINITY=compact
export CONFIG_OPTS="--with-cuda --with-copy"
export OUTPUT_SUFFIX="gpu-with-copy"

./run.sh
