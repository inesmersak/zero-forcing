clear
close all
addpath scripts/
addpath scripts/export_fig/

s = mat2str(ceil(logspace(2, 5, 20)));
strrep(s, ' ', ', ')

files = {'results/results_random_dense.csv',...
         'results/results_random_sparse.csv',...
         'results/results_path.csv',...
         'results/results_path_backwards.csv'};
ncases = length(files);
title_str = {...
    'Algoritmi preverjanja za naklju\v{c}en graf, $p=0.7$',...
    'Algoritmi preverjanja za naklju\v{c}en graf, $p=0.01$',...
    'Algoritmi preverjanja za pot, $Z = \{0\}$',...
    'Algoritmi preverjanja za pot, $Z = \{n-1\}$'};
image_name = {...
    'random_dense', 'random_sparse', 'pot_prvo_vozlisce', 'pot_zadnje_vozlisce'};
ylims = {[1, 3e3], [1, 3e3], [1, 5e4], [1, 5e4]};

label_n = 'naiven, $k=%0.2f$';
label_s = 'vrsta + mno\\v{z}ice, $k=%0.2f$';
label_c = 'vrsta + \\v{s}tevci, $k=%0.2f$';

for i = 1:ncases

M = csvread(files{i}, 1, 0);
N = M(:,1);

MM = M;
MM(MM==0) = 1;
fit_n = polyfit(log(N),log(MM(:,2)),1);
linfun_n = @(x) exp(fit_n(2)) * x.^fit_n(1);
fit_s = polyfit(log(N),log(MM(:,3)),1);
linfun_s = @(x) exp(fit_s(2)) * x.^fit_s(1);
fit_c = polyfit(log(N),log(MM(:,4)),1);
linfun_c = @(x) exp(fit_c(2)) * x.^fit_c(1);

f1 = setfig('b2', [500 400]);
plot(N, M(:,2), '-^b', N, M(:,3), '-xr', N, M(:,4), '-og')
set(gca, 'xscale', 'log')
set(gca, 'yscale', 'log')
grid on
xlabel('velikost grafa')
ylabel('\v{c}as [ms]')
legend(sprintf(label_n, fit_n(1)), sprintf(label_s, fit_s(1)), ...
sprintf(label_c, fit_c(1)), 'Location', 'northwest')
title(title_str{i})
ylim(ylims{i})

% exportf(f1, ['results/plots/', image_name{i}, '.pdf'])
% exportf(f1, ['results/plots/', image_name{i}, '.png'], '-m3')

end