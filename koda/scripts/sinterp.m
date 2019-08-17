function nv = sinterp(x, y, v, nx, ny, Method, ExtrapolationMethod)
% Interpolate scattered data outside convex hull of x, y as well.
    assert(nargin >= 5);
    if nargin < 7, ExtrapolationMethod = 'linear'; end
    if nargin < 6, Method = 'linear'; end
    if ~iscolumn(x), x = x'; end
    if ~iscolumn(y), y = y'; end
    if ~iscolumn(v), v = v'; end
    F = scatteredInterpolant(x, y, v, Method, ExtrapolationMethod);
    nv = F(nx, ny);
end
