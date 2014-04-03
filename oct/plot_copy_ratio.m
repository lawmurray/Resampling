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
          
          file1 = sprintf('results/%s-%s.nc', tolower(cs{j}), experiments{i});
          file2 = sprintf('results/%s-%s-with-copy.nc', tolower(cs{j}), experiments{i});
          l2Ps = log2(ncread(file1, 'P'));
          zs = ncread(file1, 'Z');
          
          for k = 1:2:length(zs)
              times1 = squeeze(double(ncread(file1, 'time')(:,:,k)));
              times2 = squeeze(double(ncread(file2, 'time')(:,:,k)));
              times = times2./times1;

              middle = median(times, 1)';
              err1 = quantile(times, 0.975, 1)';
              err2 = quantile(times, 0.025, 1)';
              
              h = errorbar(l2Ps, middle, err1, err2, '~');
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
                  ylabel('Execution time ratio');
              end
              grid on;
              axis(ax);
      end
  end
end
