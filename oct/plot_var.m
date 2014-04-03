% Copyright (C) 2014
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_var ()
%
% Plot variance.
%
% @end itemize
% @end deftypefn
%
function plot_var(device, algorithm, style, z)
    if nargin < 3
        print_usage ();
    elseif nargin < 4
        z = [];
    end

    % config
    ax = [4 22 1e-2 1e2];
    linestyles = {
         '-'; '-'; '-'; '-'; '-'; '--'; '--';
    };
    markerstyles = {
        '+'; 'o'; 'x'; 's'; '^'; 'd'; '*';
    };

    % gather results
    var = [];
    run = 0;
    file = sprintf('results/%s-%s-%d.nc', tolower(algorithm),
        tolower(device), run);
    while exist(file, 'file')
        Ps = ncread(file, 'P');
        l2Ps = log2(Ps);
        if !isempty(z)
            Zs = ncread(file, 'Z')(z);
            x = ncread(file, 'tr_var')(z,:);
        else
            Zs = ncread(file, 'Z');
            x = ncread(file, 'tr_var');
        end

        var = [ var x./repmat(double(Ps), 1, length(Zs)) ];
        
        run = run + 1;
        file = sprintf('results/%s-%s-%d.nc', tolower(algorithm),
          tolower(device), run);
    end

    for k = 1:2:length(Zs)
        mid = mean(var(:,k:length(Zs):end), 2);
        h = semilogy(l2Ps, mid,
            'linestyle', linestyles{style},
            'marker', markerstyles{style},
            'markerfacecolor', watercolour(style),
            'markersize', floor(1 + Zs(k)),
            'color', watercolour(style),
            'linewidth', floor(1 + Zs(k)));
    end
        
    %xlabel('log_2 N');
    %ylabel('tr(Var(o))/N');
    %grid on;
    %legend(h, algorithm, 'location', 'northwest');
    %legend('right');
    axis(ax);
end
