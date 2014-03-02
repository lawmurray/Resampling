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
    sz = [ 9 5.5 ];

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
    
    % time, bias and variance plots
    plots = {'times'; 'bias'; 'var'};
    ylabels = {'Time (s)'; '||Bias(o)||^2/N'; 'tr(Var(o))/N'};
    for i = 1:length(plots)
        f = str2func(sprintf('plot_%s', plots{i}));
        clf;
        
        subplot(2, 3, 1);
        f('CPU', 'Multinomial', 1);
        legend(get(gca, 'children')(1), 'Multinomial CPU');
        ylabel(ylabels{i});
        legend('right');
        legend('boxoff');
        grid on;
        grid minor off;
        hold on;
        f('CPU', 'Stratified', 2);
        legend(get(gca, 'children')(1), 'Stratified CPU');
        f('CPU', 'Systematic', 3);
        legend(get(gca, 'children')(1), 'Systematic CPU');
        subplot(2, 3, 2);
        f('CPU', 'Metropolis', 4);
        legend(get(gca, 'children')(1), 'Metropolis CPU');
        legend('right');
        legend('boxoff');
        grid on;
        grid minor off;
        subplot(2, 3, 3);
        f('CPU', 'Rejection', 5);
        legend(get(gca, 'children')(1), 'Rejection CPU');
        legend('right');
        legend('boxoff');
        grid on;
        grid minor off;
        
        subplot(2, 3, 4);
        f('GPU', 'Multinomial', 1);
        legend(get(gca, 'children')(1), 'Multinomial GPU');
        xlabel('log_2 N');
        ylabel(ylabels{i});
        legend('right');
        legend('boxoff');
        grid on;
        grid minor off;
        hold on;
        f('GPU', 'Stratified', 2);
        legend(get(gca, 'children')(1), 'Stratified GPU');
        f('GPU', 'Systematic', 3);
        legend(get(gca, 'children')(1), 'Systematic GPU');
        subplot(2, 3, 5);
        f('GPU', 'Metropolis', 4);
        legend(get(gca, 'children')(1), 'Metropolis GPU');
        xlabel('log_2 N');
        legend('right');
        legend('boxoff');
        grid on;
        grid minor off;
        subplot(2, 3, 6);
        f('GPU', 'Rejection', 5);
        legend(get(gca, 'children')(1), 'Rejection GPU');
        xlabel('log_2 N');
        legend('right');
        legend('boxoff');
        grid on;
        grid minor off;
        
        file = sprintf('%s/%s.pdf', FIG_DIR, plots{i});
        saveas(figure(1), file);
        system(sprintf('pdfcrop %s %s', file, file));
    end
end
