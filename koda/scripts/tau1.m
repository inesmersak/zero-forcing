function tau = tau1(sxx, syy, sxy)
% computes maxial shear stress
  tau = sqrt(1/4*(sxx - syy).^2 + sxy.^2);
end
