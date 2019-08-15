file = 'results/zfn_random_15_sparse.csv';
title_str = 'Hitrost algoritmov izracuna za nakljucen graf, p=0.01';
label_n = 'od maks. do min.';
label_s = 'od maks. do min. z mnozicami';
label_c = 'binarno iskanje';

M = csvread(file,1,0);

close all
hold on
p1 = plot(M);
p2 = plot(repmat(mean(M),size(M,1),1), '--');
ca = {[1 0 0]; [0 1 0]; [0 0 1]};
set(p1, {'color'}, ca);
set(p2, {'color'}, ca);
grid on
ylabel('cas [ms]')
legend(label_n, label_s, label_c)
title(title_str)
