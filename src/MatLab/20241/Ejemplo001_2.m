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
nep = 200;
n_ap = 1/abs(max([x1;x2]))-eps;
vMSE = zeros(1,nep);

nep_mx = nep;
im = cell(nep, 1);
for i1=1:nep
    u = [x1 x2 ones(nm,1)]*vw;
    fu = u>=0;
    err = cls-fu;
    vMSE(i1) = sqrt(err'*err)/nm;
    id_err = err~=0;
    
    y1 = -xo*vw(1)/vw(2)-vw(3)/vw(2);
    dvw = n_ap*([x1'; x2'; ones(1,nm)]*err);
    vw = vw+dvw;

    if i1>2
        if (vMSE(i1)==0)&&(vMSE(i1-1)>0)
            nep_mx = i1;
        end
    end

    fig1 = figure(1);
    plot(x1(id0), x2(id0), 'ro');
    axis([rng_mn, rng_mx, rng_mn, rng_mx])
    hold on;
    plot(x1(id1), x2(id1), 'ks');
    plot(x1(id_err), x2(id_err), 'b*');
    plot(xo, yo, 'b-');
    plot(xo, y1, 'k-');
    xlabel('x_1');
    ylabel('x_2');
    grid on;
    title(sprintf('Perceptrón simple (Epoca = %d, MSE = %.4f)', i1, vMSE(i1)));
    hold off;
    frame = getframe(fig1);
    im{i1} = frame2im(frame);
end

filename = 'testAnimated.gif';
for idx = 1:nep_mx
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end
end

figure(2)
plot(1:nep_mx,vMSE(1:nep_mx),'b*-');
axis([1, nep_mx, min(vMSE), max(vMSE)]);
grid on;
ylabel('MSE');
xlabel('Epoca');
title('Grafica de desempeño para un perceptrón simple');
print('-f2', '-djpeg90', '-r300', 'Desempeno.jpg')