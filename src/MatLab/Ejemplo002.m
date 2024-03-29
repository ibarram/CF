clc;
close all;
clear;

rng_mx = 10;
rng_mn = -10;
rng_d = 0.1;
rng_n = floor((rng_mx-rng_mn)/rng_d)+1;
nm = 100;

x1 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
x2 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
x3 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;

va = (rng_mx-rng_mn)*rand(1, 4)+rng_mn;

x3e = -va(1).*x1(:)/va(3)-va(2).*x2(:)/va(3)-va(4)/va(3);
cls = x3>x3e;
id0 = cls==0;
id1 = ~id0;

vx = rng_mn:rng_d:rng_mx;
x1o = ones(rng_n,1)*vx;
x2o = vx'*ones(1,rng_n);
x3o = -va(1).*x1o(:)/va(3)-va(2).*x2o(:)/va(3)-va(4)/va(3);
m3o = zeros(rng_n, rng_n);
m3o(:) = x3o(:);

figure(1);
mesh(vx, vx, m3o);
hold on;
plot3(x1(id0), x2(id0), x3(id0), 'ro');
plot3(x1(id1), x2(id1), x3(id1), 'ks');
axis([rng_mn, rng_mx, rng_mn, rng_mx, rng_mn, rng_mx]);
xlabel('x_1');
ylabel('x_2');
zlabel('x_3');
grid on;

vw = rand(4,1);
nep = 100;
n_ap = 1/abs(max([x1;x2;x3]))-eps;
vMSE = zeros(1,nep);

my = zeros(rng_n, rng_n);
for i1=1:nep
    u = [x1 x2 x3 ones(nm,1)]*vw;
    fu = u>=0;
    err = cls-fu;
    vMSE(i1) = sqrt(err'*err)/nm;
    id_err = err~=0;
    
    y1 = -vw(1).*x1o(:)/vw(3)-vw(2).*x2o(:)/vw(3)-vw(4)/vw(3);
    my(:) = y1(:);
    
    dvw = n_ap*([x1'; x2'; x3'; ones(1,nm)]*err);
    vw = vw+dvw;

    figure(1);
    mesh(vx,vx, m3o);
    hold on;
    plot3(x1(id0), x2(id0), x3(id0), 'ro');
    plot3(x1(id1), x2(id1), x3(id1), 'ks');
    plot3(x1(id_err), x2(id_err), x3(id_err), 'b*');
    mesh(vx, vx, my, 'FaceColor', [0.8500 0.3250 0.0980]);
    axis([rng_mn, rng_mx, rng_mn, rng_mx, rng_mn, rng_mx]);
    title(sprintf('Perceptrón simple (Epoca = %d, MSE = %.4f)', i1, vMSE(i1)));
    xlabel('x_1');
    ylabel('x_2');
    zlabel('x_3');
    grid on;
    hold off;
    pause(0.1);
end

figure(2)
plot(1:nep,vMSE,'b*-');
grid on;
ylabel('MSE');
xlabel('Epoch');