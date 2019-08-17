clear
close all
addpath scripts/
addpath scripts/export_fig/

files = {...
    'results/zfn_random_15_sparse.csv',...
    'results/zfn_random_15_mid.csv',...
    'results/zfn_random_15_dense.csv'};
ncases = length(files);
title_str = {...
    'Algoritmi izra\v{c}una za naklju\v{c}en graf, $p=0.01$',...
    'Algoritmi izra\v{c}una za naklju\v{c}en graf, $p=0.4$',...
    'Algoritmi izra\v{c}una za naklju\v{c}en graf, $p=0.7$'};

image_name = {'zfn_random_15_sparse', 'zfn_random_15_mid',...
    'zfn_random_15_dense'};

label_n = 'od maks. do min.';
label_s = 'od maks. do min. z mno\v{z}icami';
label_c = 'binarno iskanje';

for i = 1:ncases
    
M = csvread(files{i}, 1, 0);

f1 = setfig('b2', [475 400]);
p1 = plot(M, 'LineWidth', 0.5);
p2 = plot(repmat(mean(M),size(M,1),1), '--');
ca = {[1 0 0]; [0 1 0]; [0 0 1]};
set(p1, {'color'}, ca);
set(p2, {'color'}, ca);
ylabel('\v{c}as [ms]')
legend(label_n, label_s, label_c)
title(title_str{i})
xlabel('')

% exportf(f1, ['results/plots/', image_name{i}, '.pdf'])
% exportf(f1, ['results/plots/', image_name{i}, '.png'], '-m3')

end