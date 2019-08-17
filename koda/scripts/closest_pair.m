function [min_dist, min_p1, min_p2] = closest_pair(x, y)
% Returns closest pair between two sets of points, given with x and y coordinates.

if isrow(x), x = x'; end
if isrow(y), y = y'; end

KDT = KDTreeSearcher([x, y]);
idx = knnsearch(KDT, [x, y], 'K', 2);
dist = sqrt((x - x(idx(:, 2))).^2 + (y - y(idx(:, 2))).^2);
[min_dist, I] = min(dist);
min_p1 = I;
min_p2 = idx(I, 2);

end
