LibBi package: Resampling
=========================

Synopsis
--------

    ./run_cpu.sh
    ./run_gpu.sh
    ./run_metropolis.sh

or on a cluster

    qsub -t 0-15 qsub_run_cpu.sh
    qsub -t 0-15 qsub_run_gpu.sh
    qsub -t 0-15 qsub_run_metropolis.sh

This runs all experiments.

    octave --path oct --eval "plot_and_print;"

This plots the results.

Description
-----------

This package may be used to test the resampling algorithms implemented in
LibBi, reproducing the empirical results of Murray, Lee & Jacob (2014).


References
----------

L. M. Murray, A. Lee, and P. E. Jacob. Parallel resampling in the particle
filter, 2014. [\[arXiv\]](http://arxiv.org/abs/1301.4019)
