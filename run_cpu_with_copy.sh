#!/bin/sh

export KMP_AFFINITY=compact
export CONFIG_OPTS="--with-copy"
export OUTPUT_SUFFIX="cpu-with-copy"

./run.sh
