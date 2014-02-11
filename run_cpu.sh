#!/bin/sh

export KMP_AFFINITY=compact
export CONFIG_OPTS=""
export OUTPUT_SUFFIX="cpu"

./run.sh
