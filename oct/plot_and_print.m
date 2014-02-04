% Copyright (C) 2011
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_and_print ()
%
% Produce plots and print for manuscript.
% @end deftypefn
%
function plot_and_print ()
    FIG_DIR = strcat(pwd, '/figs');
    sz = [ 8 6 ];

    % output setup
    figure(1, 'visible', 'off');
    h = figure(1);
    set (h, 'papersize', sz);
    set (h, 'paperposition', [0,0,sz]);
    if sz(1) > sz (2)
        orient('landscape');
    else
        orient('portrait');
    end

    mkdir(FIG_DIR);
    
    % decision tables
    clf;
    subplot(1, 3, 1);
    plot_decisions('CPU', 'CPU');
    subplot(1, 3, 2);
    plot_decisions('GPU', 'GPU');
    subplot(1, 3, 3);
    plot_decisions('CPU', 'GPU');
    file = sprintf('%s/decisions.pdf', FIG_DIR);
    saveas(figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));
    
    % execution time plot
    clf;
    subplot(2, 3, 1);
    plot_times('CPU', 'ESS', 6);
    hold on;
    plot_times('CPU', 'Sort', 7);
    plot_times('CPU', 'Multinomial', 1);
    plot_times('CPU', 'Stratified', 2);
    plot_times('CPU', 'Systematic', 3);
    hold off;
    subplot(2, 3, 2);
    plot_times('CPU', 'Metropolis', 4);
    subplot(2, 3, 3);
    plot_times('CPU', 'Rejection', 5);
    subplot(2, 3, 4);
    plot_times('GPU', 'ESS', 6);
    plot_times('GPU', 'Sort', 7);
    hold on;
    plot_times('GPU', 'Multinomial', 1);
    plot_times('GPU', 'Stratified', 2);
    plot_times('GPU', 'Systematic', 3);
    hold off;
    subplot(2, 3, 5);
    plot_times('GPU', 'Metropolis', 4);
    subplot(2, 3, 6);
    plot_times('GPU', 'Rejection', 5);

    file = sprintf('%s/times.pdf', FIG_DIR);
    saveas(figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));

    % bias plot
    clf;
    subplot(2, 2, 1);
    plot_bias('CPU', 'Multinomial', 1);
    hold on;
    plot_bias('CPU', 'Stratified', 2);
    plot_bias('CPU', 'Systematic', 3);
    plot_bias('CPU', 'Metropolis', 4);
    plot_bias('CPU', 'Rejection', 5);
    subplot(2, 2, 2);
    plot_bias('GPU', 'Multinomial', 1);
    hold on;
    plot_bias('GPU', 'Stratified', 2);
    plot_bias('GPU', 'Systematic', 3);
    plot_bias('GPU', 'Metropolis', 4);
    plot_bias('GPU', 'Rejection', 5);

    subplot(2, 2, 3);
    plot_bias('CPU-with-copy', 'Multinomial', 1);
    hold on;
    plot_bias('CPU-with-copy', 'Stratified', 2);
    plot_bias('CPU-with-copy', 'Systematic', 3);
    plot_bias('CPU-with-copy', 'Metropolis', 4);
    plot_bias('CPU-with-copy', 'Rejection', 5);
    subplot(2, 2, 4);
    plot_bias('GPU-with-copy', 'Multinomial', 1);
    hold on;
    plot_bias('GPU-with-copy', 'Stratified', 2);
    plot_bias('GPU-with-copy', 'Systematic', 3);
    plot_bias('GPU-with-copy', 'Metropolis', 4);
    plot_bias('GPU-with-copy', 'Rejection', 5);

    file = sprintf('%s/bias.pdf', FIG_DIR);
    saveas(figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));

    % MSE plot
    clf;
    subplot(2, 2, 1);
    plot_mse('CPU', 'Multinomial', 1);
    hold on;
    plot_mse('CPU', 'Stratified', 2);
    plot_mse('CPU', 'Systematic', 3);
    plot_mse('CPU', 'Metropolis', 4);
    plot_mse('CPU', 'Rejection', 5);
    subplot(2, 2, 2);
    plot_mse('GPU', 'Multinomial', 1);
    hold on;
    plot_mse('GPU', 'Stratified', 2);
    plot_mse('GPU', 'Systematic', 3);
    plot_mse('GPU', 'Metropolis', 4);
    plot_mse('GPU', 'Rejection', 5);

    subplot(2, 2, 3);
    plot_mse('CPU-with-copy', 'Multinomial', 1);
    hold on;
    plot_mse('CPU-with-copy', 'Stratified', 2);
    plot_mse('CPU-with-copy', 'Systematic', 3);
    plot_mse('CPU-with-copy', 'Metropolis', 4);
    plot_mse('CPU-with-copy', 'Rejection', 5);
    subplot(2, 2, 4);
    plot_mse('GPU-with-copy', 'Multinomial', 1);
    hold on;
    plot_mse('GPU-with-copy', 'Stratified', 2);
    plot_mse('GPU-with-copy', 'Systematic', 3);
    plot_mse('GPU-with-copy', 'Metropolis', 4);
    plot_mse('GPU-with-copy', 'Rejection', 5);

    file = sprintf('%s/mse.pdf', FIG_DIR);
    saveas(figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));
end
