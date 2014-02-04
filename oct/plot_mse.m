% Copyright (C) 2014
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_mse ()
%
% Plot mse.
%
% @end itemize
% @end deftypefn
%
function plot_mse(device, algorithm, style)
    ax = [4 20 -2 2];
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
        sses = squeeze(nc{'sse'}(k,:,:));
        mse = log10(sum(sses, 2)) - log10(Ps) - log10(rows(sses)) + 0.5*l2Ps;
        
        h = plot(l2Ps, mse);
        set(h, 'linestyle', linestyles{style});
        set(h, 'marker', markerstyles{style});
        set(h, 'markerfacecolor', watercolour(style));
        set(h, 'markersize', 1 + zs(k));
        set(h, 'color', watercolour(style));
        set(h, 'linewidth', zs(k));

        xlabel('log_2 N');
        ylabel('log_{10} (MSE) + (log_2 N)/2');
        grid on;
        if k == length(zs)
            legend(h, algorithm, 'location', 'northeast');
        end
        legend('left');
        %axis(ax);
        hold on;
    end
end
