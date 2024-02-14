clc;
close all;
clear;

rng_mx = 10;
rng_mn = -10;
nm = 100;

x1 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
x2 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
xo = sort(x1);

rng_rng = rng_mx-rng_mn;
thx1 = rng_rng*rand(1)/2+rng_mn+rng_rng/4;
thx2 = rng_rng*rand(1)/2+rng_mn+rng_rng/4;

ids1 = x1>thx1;
ids2 = x2>thx2;
cls = (ids1&ids2)|(~ids1&~ids2);
id0 = cls==0;
id1 = ~id0;

figure(1);
plot(x1(id0), x2(id0), 'ro');
axis([rng_mn, rng_mx, rng_mn, rng_mx])
hold on;
plot(x1(id1), x2(id1), 'ks');
xlabel('x_1');
ylabel('x_2');
grid on;
title('Percentrón Multicapa');
hold off;

x = [x1, x2];

S_MLP = [3, 2, 1];
FA_MLP = {@fa_th, @fa_th, @fa_s};
MLP1 = crear_MLP(x, S_MLP, FA_MLP);
y1 = sim_MLP(x, MLP1);

