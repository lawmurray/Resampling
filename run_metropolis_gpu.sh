#!/bin/sh

export KMP_AFFINITY="compact"

for SEED in `seq 0 15`
do
  export CONFIG_OPTS="--with-cuda --seed $SEED"
  export OUTPUT_SUFFIX="gpu-$SEED"

  ./run_metropolis.sh
done
