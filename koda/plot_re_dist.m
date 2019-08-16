file = 'results/re_zfn_dist_18.csv';
title_str = 'Vrednost Z(G) za razlicne vrednosti p v modelu ER, n=18';

M = csvread(file);
N = M(1,1:end-1);
M = M(2:end,:)';
aM = mean(M);
maxM = max(M);
minM = min(M);

close all
hold on
% plot(N, aM, N, aM+var(M), '--c', N, aM-var(M), '--c');
boxplot(M(:,1:10:end), N(1:10:end));
grid on
xlabel('p')
ylabel('Z(G)')
title(title_str)
legend('povprecje', 'varianca')
