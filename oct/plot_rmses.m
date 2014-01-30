% Copyright (C) 2012
% Author: Lawrence Murray <lawrence.murray@csiro.au>
% $Rev$
% $Date$

% -*- texinfo -*-
% @deftypefn {Function File} plot_rmses ()
%
% Plot RMSEs.
%
% @end itemize
% @end deftypefn
%
function plot_rmses()
    clf;
    cs = {
        'multinomial';
        'stratified';
	'systematic';
        'metropolis';
        'rejection';
        };
    ys = [3, 5, 7];
    
    for j = 1:length(ys)
      subplot(1, length(ys), j);
      for i = 1:length(cs)
        nc = netcdf(sprintf('results/%s-%s.nc', cs{i}, 'cpu'), 'r');
      P = nc{'P'}(:);
      P2 = log2(P);
      sqerrs2 = squeeze(nc{'sqerr'}(ys(j),:,:)).^2;
      mean2 = mean(sqerrs2, 2).*P;

      h = plot(P2, mean2, linestyle(i), 'color', watercolour(i), 'linewidth', 5);
      if j == length(ys)
        legend(h, sprintf('%c%s', upper(cs{i}(1)), cs{i}(2:end)));
      end
      grid on;
      hold on;
    end

    xlabel('log_2 N');
    if j == 1
        ylabel('MSE \cdot P^{1/2}', 'interpreter', 'tex');
    end
    if j == length(ys)
      legend("location", "East")
    end
    axis('tight');
end
