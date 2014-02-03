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
function plot_copy_ratio()
    clf;
    experiments = {
        'cpu';
        'gpu';
    };
    cs = {
        'Multinomial';
        'Stratified';
	'Systematic';
        'Metropolis';
        'Rejection';
        'ESS';
        'Sort';
    };
    ax = [4 20 0 4];
    
    for i = 1:length(experiments)
      for j = 1:length(cs)
          subplot(length(experiments), length(cs), (i - 1)*length(cs) + j);
          
          nc1 = netcdf(sprintf('results/%s-%s.nc', tolower(cs{j}), experiments{i}), 'r');
          nc2 = netcdf(sprintf('results/%s-%s-with-copy.nc', tolower(cs{j}), experiments{i}), 'r');
          l2Ps = log2(nc1{'P'}(:));
          zs = nc1{'z'}(:);
          
          for k = 1:2:length(zs)
              times1 = squeeze(nc1{'time'}(k,:,:));
              times2 = squeeze(nc2{'time'}(k,:,:));
              times = times2./times1;
              
              %middle = median(times, 2);
              %upper = quantile(times, 0.975, 2);
              %lower = quantile(times, 0.025, 2);
              
              %middle = mean(times, 2);
              %upper = middle + std(times, 0, 2);
              %lower = middle - std(times, 0, 2);

              middle = median(times, 2);
              upper = middle;
              lower = zeros(size(upper));
              err1 = quantile(times, 0.975, 2);
              err2 = quantile(times, 0.025, 2);
              
              hold off;
              %area_between(l2Ps, lower, upper, watercolour(j), 1.0, 0.2);
              hold on;
              %if strcmp(cs{j}, 'Rejection')
                  h = errorbar(l2Ps, middle, err1, err2, '~');
                  %else
                  %h = plot(l2Ps, middle);
                  %end
              set(h, 'linestyle', linestyle(j));
              set(h, 'color', watercolour(j));
              set(h, 'linewidth', zs(k));
              if i == 1
                  title(cs{j});
              end
              if i == length(experiments)
                  xlabel('log_2 N');
              end
              if j == 1
                  ylabel('Execution time (\mu s)');
              end
              grid on;
              axis(ax);
      end
  end
end
