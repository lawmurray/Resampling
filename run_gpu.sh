#!/bin/sh

export KMP_AFFINITY=compact
export CONFIG_OPTS="--with-cuda"
export OUTPUT_SUFFIX="gpu"

./run.sh
