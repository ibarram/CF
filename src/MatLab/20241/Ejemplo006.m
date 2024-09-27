clc;
close all;
clear;

rng_mx = 10;
rng_mn = -10;
rng_d = 0.1;
rng_n = floor((rng_mx-rng_mn)/rng_d)+1;
vx = rng_mn:rng_d:rng_mx;
x1o = ones(rng_n,1)*vx;
x2o = vx'*ones(1,rng_n);
m3o = zeros(rng_n, rng_n);

nm = 200;

x1 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
x2 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;

rng_rng = rng_mx-rng_mn;
cx1 = rng_rng*rand(1)/2+rng_mn+rng_rng/4;
cx2 = rng_rng*rand(1)/2+rng_mn+rng_rng/4;
rc = rng_rng*rand()/8+rng_rng/8;

x21 = sqrt(rc.^2 - (x1 - cx1).^2) + cx2;
x22 = -sqrt(rc.^2 - (x1 - cx1).^2) + cx2;

ids1 = imag(x21)==0;
ids2 = real(x21)>=x2;
ids3 = real(x22)<=x2;
cls = ids1&ids2&ids3;
id0 = cls==0;
id1 = ~id0;

fig1 = figure(1);
plot(x1(id0), x2(id0), 'ro');
hold on;
plot(x1(id1), x2(id1), 'ks');
axis([rng_mn, rng_mx, rng_mn, rng_mx]);
xlabel('x_1');
ylabel('x_2');
grid on;
title('Perceptrón simple (Epoca = 0, MSE = 1)');
hold off;
pause(0.1);

% w1.*x1.^2+w2.*x2.^2+w3.*x1+w4.*x2+th
vw = rand(5,1);
nep = 1000;
rz = ceil(sum(id0)/sum(id1));
n_ap = 1/(rz*abs(max([x1;x2;x1.^2;x2.^2])))-eps;
vMSE = zeros(1,nep);
for i1=1:nep
    u = [x1.^2 x2.^2 x1 x2 ones(nm,1)]*vw;
    fu = u>=0;
    err = cls-fu;
    vMSE(i1) = sqrt(err'*err)/nm;
    id_err = err~=0;

    y1 = [x1o(:).^2 x2o(:).^2 x1o(:) x2o(:) ones(rng_n*rng_n,1)]*vw;
    m3o(:) = y1(:)>=0;

    dvw = n_ap*([x1'.^2; x2'.^2; x1'; x2'; ones(1,nm)]*err);
    vw = vw+dvw;

    fig1 = figure(1);
    contour(vx, vx, m3o);
    hold on;
    plot(x1(id0), x2(id0), 'ro');
    plot(x1(id1), x2(id1), 'ks');
    plot(x1(id_err), x2(id_err), 'b*');
    axis([rng_mn, rng_mx, rng_mn, rng_mx]);
    xlabel('x_1');
    ylabel('x_2');
    grid on;
    title(sprintf('Perceptrón simple (Epoca = %d, MSE = %.4f)', i1, vMSE(i1)));
    hold off;
    pause(0.1);

end

figure(2)
plot(1:nep,vMSE,'b*-');
axis([1, nep, min(vMSE), max(vMSE)]);
grid on;
ylabel('MSE');
xlabel('Epoca');
title('Grafica de desempeño para un perceptrón simple');