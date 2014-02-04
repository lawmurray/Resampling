% Copyright (C) 2014
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_bias ()
%
% Plot bias.
%
% @end itemize
% @end deftypefn
%
function plot_bias(device, algorithm, style)
    ax = [4 20 -12 -6];
    nc = netcdf(sprintf('results/%s-%s.nc', tolower(algorithm), tolower(device)), 'r');
    Ps = nc{'P'}(:);
    l2Ps = log2(Ps);
    zs = nc{'z'}(:);
    
    linestyles = {
         '-'; '-'; '-'; '-'; '-'; '--'; '--';
    };
    markerstyles = {
        '+'; 'o'; 'x'; 's'; '^'; 'd'; '*';
    };

    for k = 1:2:length(zs)
        ses = squeeze(nc{'se'}(k,:,:));
        bias = log10(sum(ses, 2)) - log10(Ps) - log10(rows(ses));
        
        h = plot(l2Ps, bias);
        set(h, 'linestyle', linestyles{style});
        set(h, 'marker', markerstyles{style});
        set(h, 'markerfacecolor', watercolour(style));
        set(h, 'markersize', 1 + zs(k));
        set(h, 'color', watercolour(style));
        set(h, 'linewidth', zs(k));

        xlabel('log_2 N');
        ylabel('log_{10} (Bias)');
        grid on;
        if k == length(zs)
            legend(h, algorithm, 'location', 'northwest');
        end
        legend('right');
        %axis(ax);
        hold on;
    end
end
