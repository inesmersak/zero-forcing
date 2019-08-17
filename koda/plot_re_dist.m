clear
close all
addpath scripts/
addpath scripts/export_fig/

file = 'results/re_zfn_dist_18.csv';
title_str = 'Vrednost $Z(G)$ za razli\v{c}ne vrednosti $p$ v modelu ER, $n=18$';

M = csvread(file);
N = M(1,1:end-1);
M = M(2:end,:)';
aM = mean(M);
maxM = max(M);
minM = min(M);

f1 = setfig('b2', [600 400]);
boxplot(M(:,1:10:end), N(1:10:end));
grid on
set(gca,'TickLabelInterpreter','latex')
xlabel('$p$')
ylabel('$Z(G)$')
title(title_str)
% legend('povpre\v{c}je', 'standardni odklon')


f2 = setfig('b4', [600 400]);
plot(N, aM, '-r');
plot(N, aM+std(M), '--k', 'LineWidth', 0.75);
plot(N, aM-std(M), '--k', 'LineWidth', 0.75);
xlabel('$p$')
ylabel('$Z(G)$')
title(title_str)
legend('povpre\v{c}je', 'standardni odklon', 'Location', 'SE');


% exportf(f2, 'results/plots/er_zfn_dist_18_avg.pdf')
% exportf(f2, 'results/plots/er_zfn_dist_18_avg.png', '-m3')
% exportf(f1, 'results/plots/er_zfn_dist_18_boxplot.pdf')
% exportf(f1, 'results/plots/er_zfn_dist_18_boxplot.png', '-m3')