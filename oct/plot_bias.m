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
function plot_bias(device, algorithm, style, z)
    if nargin < 3
        print_usage ();
    elseif nargin < 4
        z = [];
    end
    
    % config
    ax = [4 22 1e-4 1];
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
        Ps = ncread(file, 'P');
        l2Ps = log2(Ps);
        if !isempty(z)
            Zs = ncread(file, 'Z')(z);
            x = ncread(file, 'bias2')(z,:);
        else
            Zs = ncread(file, 'Z');
            x = ncread(file, 'bias2');
        end
        bias2 = [ bias2 x./repmat(double(Ps), 1, length(Zs)) ];
        
        run = run + 1;
        file = sprintf('results/%s-%s-%d.nc', tolower(algorithm),
          tolower(device), run);
    end

    for k = 1:2:length(Zs)
        mid = mean(bias2(:,k:length(Zs):end), 2);
        h = semilogy(l2Ps, mid,
            'linestyle', linestyles{style},
            'marker', markerstyles{style},
            'markerfacecolor', watercolour(style),
            'markersize', floor(1 + Zs(k)),
            'color', watercolour(style),
            'linewidth', floor(1 + Zs(k)));
    end
        
    %xlabel('log_2 N');
    %ylabel('||Bias(o)||^2/N');
    %grid on;
    %legend(h, algorithm, 'location', 'northwest');
    %legend('right');
    axis(ax);
end
