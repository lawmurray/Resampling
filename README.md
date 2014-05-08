LibBi package: Resampling
=========================

Synopsis
--------

    ./run_cpu.sh
    ./run_gpu.sh
    ./run_metropolis_cpu.sh
    ./run_metropolis_gpu.sh

or on a cluster:

    qsub -t 0-15 qsub_run_cpu.sh
    qsub -t 0-15 qsub_run_gpu.sh
    qsub -t 0-15 qsub_run_metropolis_cpu.sh
    qsub -t 0-15 qsub_run_metropolis_gpu.sh

This runs all experiments.

    octave --path oct --eval "plot_and_print;"

This plots the results.

Outputs are produced as NetCDF files in the `results/` directory. Each file
name indicates the name of the algorithm and the seed that was used to
simulate weight sets for testing. The contents of each file give the results
of repeated runs of the algorithm on combinations of variance of weights and
number of weights. For each run, the execution time is reported. For each
combination of variance of weights and number of weights, the squared bias and
variance of outcomes across all repetitions is reported. See Murray, Lee &
Jacob (2014) for more information.


Description
-----------

This package may be used to test the resampling algorithms implemented in
LibBi, reproducing the empirical results of Murray, Lee & Jacob (2014). It
uses the `test_resampler` test command of LibBi; for more information run
`libbi help test_resampler`.


References
----------

L. M. Murray, A. Lee, and P. E. Jacob. Parallel resampling in the particle
filter, 2014. [\[arXiv\]](http://arxiv.org/abs/1301.4019)
