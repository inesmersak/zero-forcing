 function [C, handler] = scontour(x, y, v, xden, yden, varargin) %contour with supplied vectors of data instead of mesh
  x = double(x);
  y = double(y);
  v = double(v);
  if isscalar(xden)
    xden = linspace(min(x), max(x), xden);
  end
  if isscalar(yden)
    yden = linspace(min(y), max(y), yden);
  end
  [X,Y] = meshgrid(xden, yden);
  Z = griddata(x, y, v, X, Y, 'linear');
  [C, handler] = contourf(X, Y, Z, varargin{:});
  
end
