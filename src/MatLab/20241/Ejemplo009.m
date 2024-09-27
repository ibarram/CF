clc;
close all;
clear;

rng_mx = 10;
rng_mn = -10;
nm = 100;

x1 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
x2 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;

%m = rand();
m = 0.8074;
%b = rand();
b = 0.6550;
xo = sort(x1);
yo = m.*xo+b;
x2e = m.*x1+b;
cls = x2>x2e;
id0 = cls==0;
id1 = ~id0;

vw = rand(3,1);
nep = 100;
n_ap = 1/abs(max([x1;x2]))-eps;
mu = 0.7;
vw1 = vw;
avw1 = vw1;
vMSE = zeros(1,nep);
vMSE1 = zeros(1,nep);
md = 0;
vr = 0.1;

for i1=1:nep
    u = [x1 x2 ones(nm,1)]*vw;
    %fu = u>=0;
    %fu = 1./(1+exp(-u));
    fu = exp(-((u-md).^2)./vr);
    %dfu = fu.*(1-fu);
    dfu = (-2*(u-md)./vr).*fu;
    err = cls-fu;
    vMSE(i1) = sqrt(err'*err)/nm;
    id_err = err>(1e6*eps);

    u1 = [x1 x2 ones(nm,1)]*vw1;
    %fu1 = u1>=0;
    %fu1 = 1./(1+exp(-u1));
    fu1 = exp(-((u1-md).^2)./vr);
    %dfu1 = fu1.*(1-fu1);
    dfu1 = (-2*(u1-md)./vr).*fu1;
    err1 = cls-fu1;
    vMSE1(i1) = sqrt(err1'*err1)/nm;
    id_err1 = err>(1e6*eps);
    
    y1 = -xo*vw(1)/vw(2)-vw(3)/vw(2);
    dvw = n_ap*([x1'; x2'; ones(1,nm)]*err);
    vw = vw+dvw;

    y2 = -xo*vw1(1)/vw1(2)-vw1(3)/vw1(2);
    dvw1 = n_ap*([x1'; x2'; ones(1,nm)]*err1);
    aavw1 = avw1;
    avw1 = vw1;
    vw1 = vw1+dvw1+mu*(avw1-aavw1);

    figure(1);
    plot(x1(id0), x2(id0), 'ro');
    axis([rng_mn, rng_mx, rng_mn, rng_mx])
    hold on;
    plot(x1(id1), x2(id1), 'ks');
    plot(x1(id_err), x2(id_err), 'b*');
    plot(xo, yo, 'b-');
    plot(xo, y1, 'k--');
    plot(xo, y2, 'k-.');
    xlabel('x_1');
    ylabel('x_2');
    grid on;
    title(sprintf('Perceptrón simple (Epoca = %d, MSE = %.4f)', i1, vMSE(i1)));
    hold off;
    pause(0.1);

end

figure(2)
plot(1:nep,vMSE,'b*-');
hold on;
plot(1:nep,vMSE1,'ko-');
axis([1, nep, min(vMSE), max(vMSE)]);
grid on;
ylabel('MSE');
xlabel('Epoca');
title('Grafica de desempeño para un perceptrón simple');