% -*- texinfo -*-
% @deftypefn {Function File} plot_surfs ()
%
% Plot times.
%
% @end itemize
% @end deftypefn
%
function plot_surfs()
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
        nc = netcdf(sprintf('results/%s-%s.nc', cs{i}, backends{j}),
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
    lvls = [mn:0.25:mx]; %linspace(mn, mx, 21);
    %colormap(cool(64).*repmat(linspace(0.0, 1.0, 64)', 1, 3))
    %colormap(hot);
    %colormap(jet);
    colormap(flipud(gray));

    % algorithm plots
    for j = 1:B
      for i = 1:C
        subplot(B, C, (j - 1)*C + i);
        cla;
        [Cs, H] = contourf(P1, Z1, all{j}(:,:,i), lvls);
        %shading('flat');
        axis([min(P1) max(P1) min(Z1) max(Z1)]);
        caxis([mn, mx]);
        clabel(Cs, H, [mn:1:mx], 'LabelSpacing', 100);
        if j == 1
          title(sprintf('%c%s', upper(cs{i}(1)), cs{i}(2:end)));
        end
        if j == B
          xlabel('log_2 N');
        end
        if i == 1
          ylabel('y');
        end
        if j == B && i == 1
           colorbar('West');
        end
        hold on;

        % backend best
        mask = best{j} == i;
        polys = bwboundaries(mask');
        for k = 1:length(polys)
          c = watercolour(i);
          %c = [1 1 1];
          line(P1(polys{k}(:,1)), Z1(polys{k}(:,2)), 'color', c,
              'linewidth', 5, 'linestyle', '--');
        end

        % overall best
        mask = best{j} == i & bestmn{j} < bestmn{mod(j,2) + 1};
        polys = bwboundaries(mask');
        for k = 1:length(polys)
          c = watercolour(i);
          %c = [1 1 1];
          line(P1(polys{k}(:,1)), Z1(polys{k}(:,2)), 'color', c,
              'linewidth', 5, 'linestyle', '-');
        end

        hold off;
      end
    end
end
