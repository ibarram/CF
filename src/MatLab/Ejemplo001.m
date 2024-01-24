clc;
close all;
clear;

rng_mx = 10;
rng_mn = -10;
nm = 100;

x1 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
x2 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;

m = rand();
b = rand();
xo = sort(x1);
yo = m.*xo+b;
x2e = m.*x1+b;
cls = x2>x2e;
id0 = cls==0;
id1 = ~id0;

vw = rand(3,1);
u = [x1 x2 ones(nm,1)]*vw;
fu = u>=0;
err = cls-fu;
id_err = err~=0;

figure(1);
plot(x1(id0), x2(id0), 'ro');
hold on;
plot(x1(id1), x2(id1), 'ks');
plot(x1(id_err), x2(id_err), 'b*');
plot(xo, yo, 'b-');
grid on;
