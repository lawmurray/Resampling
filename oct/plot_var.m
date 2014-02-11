% Copyright (C) 2014
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_var ()
%
% Plot var.
%
% @end itemize
% @end deftypefn
%
function plot_var(device, algorithm, style)
    ax = [4 20 1e-2 1e2];
    nc = netcdf(sprintf('results/%s-%s.nc', tolower(algorithm), tolower(device)), 'r');
    Ps = nc{'P'}(:);
    l2Ps = log2(Ps);
    zs = nc{'Z'}(:);
    
    linestyles = {
         '-'; '-'; '-'; '-'; '-'; '--'; '--';
    };
    markerstyles = {
        '+'; 'o'; 'x'; 's'; '^'; 'd'; '*';
    };

    for k = 1:2:length(zs)
        var = nc{'tr_var'}(k,:)'./Ps;
        
        h = semilogy(l2Ps, var);
        set(h, 'linestyle', linestyles{style});
        set(h, 'marker', markerstyles{style});
        set(h, 'markerfacecolor', watercolour(style));
        set(h, 'markersize', 1 + zs(k));
        set(h, 'color', watercolour(style));
        set(h, 'linewidth', zs(k));

        xlabel('log_2 N');
        ylabel('tr(Var(o))/N');
        grid on;
        if k == length(zs)
            legend(h, algorithm, 'location', 'northwest');
        end
        legend('right');
        axis(ax);
        hold on;
    end
end
