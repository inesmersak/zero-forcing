function v = von_mises(sxx, syy, sxy_szz, nu_sxy, sxz, syz)
% Computes von Mises stress in 2D and 3D
%
% When 3 arguments are given, plane stress formula is used and the arguments are sxx, syy and sxy.
% For plane strain, Poisson's ratio nu must be supplied as 4th argument.
% For full 3D plane stress, 6 arguments representing sxx, syy, szz, sxy, sxz, syz must be supplied.

if nargin == 3
  sxy = sxy_szz;
  v = sqrt(sxx.^2 - sxx.*syy + syy.^2 + 3*sxy.^2);
elseif nargin == 4
  sxy = sxy_szz;
  szz = nu_sxy*(sxx+syy);
  v = sqrt(sxx.^2+3.*sxy.^2+syy.^2+(-1).*syy.*szz+szz.^2+(-1).*sxx.*(syy+...
      szz));
elseif nargin == 6
  szz = sxy_szz;
  sxy = nu_sxy;
  v = sqrt(0.5*((sxx - syy).^2 + (syy - szz).^2 + (szz - sxx).^2 ...
                + 6*(sxy.^2 + sxz.^2 + syz.^2)));
else
    error('Invalid number of arguments.')
end
end
