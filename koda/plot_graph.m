s = mat2str(ceil(logspace(2, 4, 20)));
strrep(s, ' ', ', ')

%%
file = 'results/results_path.csv';
title_str = 'Hitrost algoritmov preverjanja za pot s pobarvanim prvim vozliscem';
label_n = 'naiven, k=%0.4f';
label_s = 'vrsta + mnozice, k=%0.4f';
label_c = 'vrsta + stevci, k=%0.4f';

M = csvread(file,1,0);
N = M(:,1);

MM = M;
MM(MM==0) = 1;
fit_n = polyfit(log(N),log(MM(:,2)),1);
linfun_n = @(x) exp(fit_n(2)) * x.^fit_n(1);
fit_s = polyfit(log(N),log(MM(:,3)),1);
linfun_s = @(x) exp(fit_s(2)) * x.^fit_s(1);
fit_c = polyfit(log(N),log(MM(:,4)),1);
linfun_c = @(x) exp(fit_c(2)) * x.^fit_c(1);

loglog(N, M(:,2), '-sb', N, M(:,3), '-xr', N, M(:,4), '-og')
grid on
xlabel('velikost grafa')
ylabel('cas [ms]')
legend(sprintf(label_n, fit_n(1)), sprintf(label_s, fit_s(1)), ...
sprintf(label_c, fit_c(1)), 'Location', 'northwest')
title(title_str)