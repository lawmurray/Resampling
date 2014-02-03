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
    
    subplot(1, 3, 1);
    plot_decisions('CPU', 'CPU');
    subplot(1, 3, 2);
    plot_decisions('GPU', 'GPU');
    subplot(1, 3, 3);
    plot_decisions('CPU', 'GPU');
    file = sprintf('%s/decisions.pdf', FIG_DIR);
    saveas(figure(1), file);
    system(sprintf('pdfcrop %s %s', file, file));
    
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
end
