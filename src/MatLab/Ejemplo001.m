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
nep = 100;
n_ap = 1/abs(max([x1;x2]))-eps;
vMSE = zeros(1,nep);

for i1=1:nep
    u = [x1 x2 ones(nm,1)]*vw;
    fu = u>=0;
    err = cls-fu;
    vMSE(i1) = sqrt(err'*err)/nm;
    id_err = err~=0;
    
    y1 = -xo*vw(1)/vw(2)-vw(3)/vw(2);
    dvw = n_ap*([x1'; x2'; ones(1,nm)]*err);
    vw = vw+dvw;

    figure(1);
    plot(x1(id0), x2(id0), 'ro');
    axis([rng_mn, rng_mx, rng_mn, rng_mx])
    hold on;
    plot(x1(id1), x2(id1), 'ks');
    plot(x1(id_err), x2(id_err), 'b*');
    plot(xo, yo, 'b-');
    plot(xo, y1, 'k-');
    grid on;
    hold off;
    pause(0.1);

end

figure(2)
plot(1:nep,vMSE,'b*-');
ylabel('MSE');
xlabel('Epoch');