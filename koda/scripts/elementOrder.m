function R = elementOrder(M)
[i, j, v] = find(M);
v = sign(v).*log10(abs(v)+1);
R = sparse(i, j, v);
end
