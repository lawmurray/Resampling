% -*- texinfo -*-
% @deftypefn {Function File} plot_surfs ()
%
% Plot times.
%
% @end itemize
% @end deftypefn
%
function plot_decisions(backend1, backend2)
   pkg load image;

    backends = {
        backend1;
        backend2;
    };
    cs = {
        'Multinomial';
        'Stratified';
        'Systematic';
        'Metropolis';
        'Rejection';
    };

    B = length(backends);
    C = length(cs);
    P1 = linspace(4, 22, 220)';
    Z1 = linspace(0, 4, 220)';
    [PP1, ZZ1] = meshgrid(P1, Z1);

    % compute axis bounds etc
    for j = 1:B  % backends
      mx = 0.0;
      mn = 1e9;
      all{j} = [];

      for i = 1:C  % algorithms
        times = [];
        run = 0;
        file = sprintf('results/%s-%s-%d.nc', tolower(cs{i}),
            tolower(backends{j}), run);
        while exist(file, 'file')
            nc = netcdf(file, 'r');
            P2 = log2(nc{'P'}(:));
            Z2 = nc{'Z'}(:);
            [PP2, ZZ2] = meshgrid(P2, Z2);
    
            t = nc{'time'}(:,:,2:end)/1e6; % us to s, and remove first for cache
            times = cat(3, times, t);
        
            run = run + 1;
            file = sprintf('results/%s-%s-%d.nc', tolower(cs{i}),
                tolower(backends{j}), run);
        end

        mean2 = mean(times, 3);
        surf2 = interp2(PP2, ZZ2, mean2, PP1, ZZ1, 'linear');

        % aggregates
        mx = max([mx; mean2(:)]);
        mn = min([mn; mean2(:)]);
        if length(all{j}) == 0
            all{j} = zeros(rows(surf2), columns(surf2), length(cs));
        end
        all{j}(:,:,i) = surf2;
      end
    end

    % backend best
    for j = 1:B
      [bestmn{j}, best{j}] = min(all{j}, all{j}, 3);
    end

    % colouring
    mn = floor(mn);
    mx = floor(mx);

    % algorithm plots
    cla;
    hold on;
    for j = 1:B
      for i = 1:C
        % backend best
        mask = best{j} == i & bestmn{j} <= bestmn{mod(j,B) + 1};
        polys = bwboundaries(mask');
        for k = 1:length(polys)
          c = watercolour(i);
          %c = [1 1 1];
          patch(P1(polys{k}(:,1)), Z1(polys{k}(:,2)), 'facecolor', ...
              fade(c, 0.5), 'edgecolor', c, 'linewidth', 3, 'linestyle', '-');
          x = mean(P1(polys{k}(:,1)));
          y = mean(Z1(polys{k}(:,2)));
          h = text(x, y, sprintf('%s\n%s', backends{j}, cs{i}));
          set(h, 'horizontalalignment', 'center');
        end
      end
    end

    xlabel('log_2 N');
    ylabel('z');
    axis('square', 'tight');
end
