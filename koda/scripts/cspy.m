function [hp] = cspy(S)
% Draws a sparse matrix like spy, but with colored entries.
%   handle = cspy(S) plos a sparse matrix S with color.
[m, n] = size(S);

nonzeroInd = find(S);
[y, x] = ind2sub([m n], nonzeroInd);

hp = patch(x, y, S(nonzeroInd), ...
           'Marker', 's', 'MarkerFaceColor', 'flat', 'MarkerSize', 4, ...
           'EdgeColor', 'none', 'FaceColor', 'none');
set(gca, 'XLim', [0, n + 1], 'YLim', [0, m + 1], 'YDir', 'reverse', ...
    'PlotBoxAspectRatio', [n + 1, m + 1, 1]);

colorbar();
end
