function e = l1_norm(x, y, v, xmin, xmax, ymin, ymax)
% evaluates continuous L1 norm over domain given by points
e = integral2(@(X, Y) abs(interp2(x,y,v,X,Y)), xmin, xmax, ymin, ymax);
end