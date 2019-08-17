function h = plot_domain(datafile, name)

pos = h5read(datafile, [name '/pos']);
types = h5read(datafile, [name '/types']);

[n, d] = size(pos);

if d == 1

x = pos(:, 1);
y = 0*x;

hold on
scatter(x, y, 15, types, 'filled')
axis equal

normals = h5read(datafile, [name, '/normals']);
bmap = h5read(datafile, [name '/bmap'])+1;
typeidx = types < 0;
bnd = bmap(typeidx);

quiver(pos(typeidx,1), 0*pos(typeidx, 1), normals(bnd, 1), 0*normals(bnd, 1));
title(sprintf('N = %d', length(x)))
colorbar
colormap jet

elseif d == 2

x = pos(:, 1);
y = pos(:, 2);

[mind, i1, i2] = closest_pair(x, y);
if mind < 1e-9
    warning('Closest pair of points %d and %d is only %f apart.', i1, i2, mind);
end

hold on
scatter(x, y, 15, types, 'filled')
daspect([1 1 1])

normals = h5read(datafile, [name, '/normals']);
bmap = h5read(datafile, [name '/bmap'])+1;
typeidx = types < 0;
bnd = bmap(typeidx);

quiver(pos(typeidx, 1), pos(typeidx, 2), normals(bnd, 1), normals(bnd, 2));
title(sprintf('N = %d', length(x)))
colorbar
colormap jet

elseif d == 3

x = pos(:, 1);
y = pos(:, 2);
z = pos(:, 3);

hold on
scatter3(x, y, z, 15, types, 'filled')
daspect([1 1 1])

normals = h5read(datafile, [name, '/normals']);
bmap = h5read(datafile, [name '/bmap'])+1;
typeidx = types < 0;
bnd = bmap(typeidx);

quiver3(pos(typeidx, 1), pos(typeidx, 2), pos(typeidx, 3), normals(bnd, 1), normals(bnd, 2), normals(bnd, 3));
title(sprintf('N = %d', length(x)))
colorbar
colormap jet

else
    error('Plot for dimension %d not available.', d)
end

end
