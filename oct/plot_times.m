% Copyright (C) 2012
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
function plot_times()
    clf;
    backends = {
        'cpu';
        'gpu';
    };
    cs = {
        'multinomial';
        'stratified';
	'systematic';
        'metropolis';
        'rejection';
        'ess';
        'sort';
        };
    
    for j = 1:length(backends)
      subplot(1, length(backends), j);

      for i = 1:length(cs)
        nc = netcdf(sprintf('results/%s-%s.nc', cs{i}, backends{j}), 'r');
        P2 = log2(nc{'P'}(:));
        times2 = squeeze(nc{'time'}(3,:,:));
        %mean2 = mean(times2, 2);
        %std2 = std(times2, 0, 2);
        median2 = median(times2, 2);
        upper2 = quantile(times2, 0.975, 2);
        lower2 = quantile(times2, 0.025, 2);

        %area_between(P2, max(mean2 - 2*std2, 1e-6), mean2 + 2*std2,
        area_between(P2, lower2, upper2, watercolour(i), 1.0, 0.5);
        hold on;
        %h = semilogy(P2, mean2, linestyle(i), 'color', watercolour(i), 'linewidth', 5);
        h = semilogy(P2, median2, linestyle(i), 'color', watercolour(i), 'linewidth', 5);
        if j == 1
          legend(h, sprintf('%c%s', upper(cs{i}(1)), cs{i}(2:end)));
        end
        grid on;
      end

      xlabel('log_2 N');
      ylabel('\mu s');
      if j == 1
        legend("location", "NorthWest")
        legend("right");
      end
      axis([min(P2) max(P2) 10 10^5]);
  end
end
