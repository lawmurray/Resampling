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
    P1 = linspace(4, 20, 200)';
    Z1 = linspace(0, 4, 200)';
    [PP1, ZZ1] = meshgrid(P1, Z1);

    % compute axis bounds etc
    for j = 1:B  % backends
      mx = 0.0;
      mn = 1e9;
      all{j} = [];

      for i = 1:C  % algorithms
        nc = netcdf(sprintf('results/%s-%s.nc', tolower(cs{i}), tolower(backends{j})),
        'r');
        P2 = log2(nc{'P'}(:));
        Z2 = nc{'z'}(:);
        [PP2, ZZ2] = meshgrid(P2, Z2);

        times2 = nc{'time'}(:,:,:);
        mean2 = mean(times2, 3);
        surf2 = interp2(PP2, ZZ2, log10(mean2), PP1, ZZ1, 'linear');

        % aggregates
        mx = max([mx; log10(mean2(:))]);
        mn = min([mn; log10(mean2(:))]);
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
