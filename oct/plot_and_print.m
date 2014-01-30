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
    sz = [ 8.3 3 ];

    % output setup
    figure(1, 'visible', 'off');
    h = figure(1);
    set (h, 'papertype', '<custom>');
    set (h, 'paperunits', 'inches');
    set (h, 'papersize', sz);
    set (h, 'paperposition', [0,0,sz]);
    set (h, 'defaultaxesfontname', 'Helvetica')
    set (h, 'defaultaxesfontsize', 6)
    set (h, 'defaulttextfontname', 'Helvetica')
    set (h, 'defaulttextfontsize', 6)
    if sz(1) > sz (2)
        orient('landscape');
    else
        orient('portrait');
    end
    
    plot_surfs;
    epsfile = sprintf('%s/surfs.eps', FIG_DIR);
    pdffile = sprintf('%s/surfs.pdf', FIG_DIR);
    print(figure(1), epsfile, '-color');
    system(sprintf('epstopdf %s', epsfile));
    system(sprintf('pdfcrop %s %s', pdffile, pdffile));

    plot_times;
    epsfile = sprintf('%s/times.eps', FIG_DIR);
    pdffile = sprintf('%s/times.pdf', FIG_DIR);
    print(figure(1), epsfile, '-color');
    system(sprintf('epstopdf %s', epsfile));
    system(sprintf('pdfcrop %s %s', pdffile, pdffile));

    plot_rmses;
    epsfile = sprintf('%s/rmses.eps', FIG_DIR);
    pdffile = sprintf('%s/rmses.pdf', FIG_DIR);
    print(figure(1), epsfile, '-color');
    system(sprintf('epstopdf %s', epsfile));
    system(sprintf('pdfcrop %s %s', pdffile, pdffile));

end
