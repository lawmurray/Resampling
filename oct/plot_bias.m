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
    % config
    ax = [4 22 1e-5 1e-1];
    linestyles = {
         '-'; '-'; '-'; '-'; '-'; '--'; '--';
    };
    markerstyles = {
        '+'; 'o'; 'x'; 's'; '^'; 'd'; '*';
    };

    % gather results
    bias2 = [];
    run = 0;
    file = sprintf('results/%s-%s-%d.nc', tolower(algorithm),
        tolower(device), run);
    while exist(file, 'file')
        nc = netcdf(file, 'r');
        Ps = nc{'P'}(:);
        l2Ps = log2(Ps);
        Zs = nc{'Z'}(:);
    
        bias2 = [ bias2; nc{'bias2'}(:,:)./repmat(Ps', rows(Zs), 1) ];
        
        run = run + 1;
        file = sprintf('results/%s-%s-%d.nc', tolower(algorithm),
          tolower(device), run);
    end
        
    %mn = quantile(bias2, 0.025);
    %mx = quantile(bias2, 0.975);

    ish = ishold;
    %area_between(l2Ps, mn, mx, watercolour(style), 1.0, 0.5);
    hold on;
    for z = 1:2:length(Zs)
        mid = median(bias2(z:length(Zs):end,:), 1);
        h = semilogy(l2Ps, mid,
            'linestyle', linestyles{style},
            'marker', markerstyles{style},
            'markerfacecolor', watercolour(style),
            'markersize', floor(1 + 0.5*z),
            'color', watercolour(style),
            'linewidth', floor(1 + 0.5*z));
    end
    if !ish
        hold off;
    end
        
    %xlabel('log_2 N');
    %ylabel('||Bias(o)||^2/N');
    grid on;
    %legend(h, algorithm, 'location', 'northwest');
    %legend('right');
    axis(ax);
end
