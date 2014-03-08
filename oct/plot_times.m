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
function plot_times(device, algorithm, style, z)
    if nargin < 3
        print_usage ();
    elseif nargin < 4
        z = [];
    end
    
    % config
    ax = [4 22 1e-6 1e2];
    linestyles = {
         '-'; '-'; '-'; '-'; '-'; '--'; '--';
    };
    markerstyles = {
        '+'; 'o'; 'x'; 's'; '^'; 'd'; '*';
    };

    % gather results
    times = [];
    run = 0;
    file = sprintf('results/%s-%s-%d.nc', tolower(algorithm),
        tolower(device), run);
    while exist(file, 'file')
        nc = netcdf(file, 'r');
        Ps = nc{'P'}(:);
        l2Ps = log2(Ps);
        if !isempty(z)
            Zs = nc{'Z'}(z);
            t = nc{'time'}(z,:,2:end)/1e6;
        else
            Zs = nc{'Z'}(:);
            t = nc{'time'}(:,:,2:end)/1e6;
        end
    
        times = cat(3, times, t);
        
        run = run + 1;
        file = sprintf('results/%s-%s-%d.nc', tolower(algorithm),
          tolower(device), run);
    end

    %mn = quantile(times, 0.025);
    %mx = quantile(times, 0.975);

    ish = ishold;
    %area_between(l2Ps, mn, mx, watercolour(style), 1.0, 0.5);
    hold on;
    for k = 1:2:length(Zs)
        t = squeeze(times(k,:,:));
        %mn = quantile(t, 0.025, 2);
        %mx = quantile(t, 0.975, 2);
        mid = mean(t, 2);
        %area_between(l2Ps, mn, mx, watercolour(style), 1.0, 0.25);
        h = semilogy(l2Ps, mid,
            'linestyle', linestyles{style},
            'marker', markerstyles{style},
            'markerfacecolor', watercolour(style),
            'markersize', floor(1 + Zs(k)),
            'color', watercolour(style),
            'linewidth', floor(1 + Zs(k)));
            
    end
    if !ish
        hold off;
    end
        
    %xlabel('log_2 N');
    %ylabel('||Bias(o)||^2/N');
    %grid on;
    %legend(h, algorithm, 'location', 'northwest');
    %legend('right');
    axis(ax);
end
