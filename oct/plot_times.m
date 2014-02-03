% Copyright (C) 2014
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_times ()
%
% Plot times.
%
% @end itemize
% @end deftypefn
%
function plot_times(device, algorithm, style)
    ax = [4 20 0 7];          
    nc = netcdf(sprintf('results/%s-%s.nc', tolower(algorithm), tolower(device)), 'r');
    l2Ps = log2(nc{'P'}(:));
    zs = nc{'z'}(:);
    
    linestyles = {
         '-'; '-'; '-'; '-'; '-'; '--'; '--';
    };
    markerstyles = {
        '+'; 'o'; 'x'; 's'; '^'; 'd'; '*';
    };
          
    for k = 1:2:length(zs)
        times = log10(squeeze(nc{'time'}(k,:,:)));
        
        middle = mean(times, 2);
        err = std(times, 0, 2);
        
        if strcmp(algorithm, 'Rejection')
            h = errorbar(l2Ps, middle, err, '~');
        else
            h = plot(l2Ps, middle);
        end
        set(h, 'linestyle', linestyles{style});
        set(h, 'marker', markerstyles{style});
        set(h, 'markerfacecolor', watercolour(style));
        set(h, 'markersize', 1 + zs(k));
        set(h, 'color', watercolour(style));
        set(h, 'linewidth', zs(k));
        if i == 1
            title(cs{j});
        end
        xlabel('log_2 N');
        ylabel('Execution time (\mu s)');
        grid on;
        if k == length(zs)
            legend(h, algorithm, 'location', 'northwest');
        end
        legend('right');
        axis(ax);
        hold on;
    end
end
