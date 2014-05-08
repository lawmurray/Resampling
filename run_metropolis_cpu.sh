#!/bin/sh

export KMP_AFFINITY="compact"

for SEED in `seq 0 15` do
  export CONFIG_OPTS="--seed $SEED"
  export OUTPUT_SUFFIX="cpu-$SEED"

  ./run_metropolis.sh
done
