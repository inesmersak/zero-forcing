function [xo, yo, fo] = interpolateToMeshGrid(x, y, f, nx, ny, varargin)
%interpolateToMeshGrid interpolate [x,y,f] -->
% [xi,yi,fi] - where xi = min(x):max-min/nx:max(x)
%returns interpolated field fi and its meshgrid reshapes fim, xim, yim
%example:

% xx=[];
% yy=[];
% ff=[];
%
% for x=0:0.1:1
% for y=1:0.1:2
%   ff=[ff,sin(3*x.*2*y)];
%   xx=[xx,x];
%   yy=[yy,y];
% end
% end
%
% [xi,yi,fi]=interpolateToMeshGrid(xx,yy,ff,51,51,'interpolation','cubic','out','vec');
% [xim,yim,fim]=interpolateToMeshGrid(xx,yy,ff,51,51,'interpolation','cubic','out','mesh');
%
% createFig('pos',2);hold on;
%
% plot3(xx,yy,ff,'+');
% plot3(xi,yi,fi,'o');
% surf(xim,yim,fim)
% view(20,40)

p = inputParser;
addOptional(p, 'interpolation', 'linear'); %interpolation type -- linear, cubic ...
addOptional(p, 'out', 'mesh'); %what to return, meshgrids (mesh) or vectors (vec)

%%parameters parsing
try
    parse(p, varargin{:});
catch err
    fprintf(2, 'PARSER ERROR');
    disp('valid arguments >>')
    disp(p.Parameters);
    disp('error msg:')
    rethrow(err);
end

for (param = p.Parameters) eval([cell2mat(param), '=p.Results.', cell2mat(param), ';']); end

xscale = [min(x), max(x)];
yscale = [min(y), max(y)];
xi = linspace(xscale(1), xscale(2), nx);
yi = linspace(yscale(1), yscale(2), ny);

[xim, yim] = meshgrid(xi, yi);

fim = griddata(double(x), double(y), double(f), double(xim), double(yim), interpolation);
fi = reshape(fim, nx*ny, 1);
xi = reshape(xim, nx*ny, 1);
yi = reshape(yim, nx*ny, 1);


if strcmp(out, 'mesh')
    xo = xim;
    yo = yim;
    fo = fim;
else
    xo = xi;
    yo = yi;
    fo = fi;
end
