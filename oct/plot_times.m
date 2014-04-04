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
        Ps = ncread(file, 'P');
        l2Ps = log2(Ps);
        if !isempty(z)
            Zs = ncread(file, 'Z')(z);
            t = double(ncread(file, 'time')(2:end,:,z))/1e6; % skip first due to cache
        else
            Zs = ncread(file, 'Z');
            t = double(ncread(file, 'time')(2:end,:,:))/1e6; % skip first due to cache
        end
        times = cat(1, times, t);
        
        run = run + 1;
        file = sprintf('results/%s-%s-%d.nc', tolower(algorithm),
          tolower(device), run);
    end

    ish = ishold;
    for k = 1:2:length(Zs)
        t = mean(squeeze(times(:,:,k)), 1);
        h = semilogy(l2Ps, t,
            'linestyle', linestyles{style},
            'marker', markerstyles{style},
            'markerfacecolor', watercolour(style),
            'markersize', floor(1 + Zs(k)),
            'color', watercolour(style),
            'linewidth', floor(1 + Zs(k)));
        hold on;
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
