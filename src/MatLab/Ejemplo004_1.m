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

nm = 100;

x1 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
x2 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;

rng_rng = rng_mx-rng_mn;
thx1 = rng_rng*rand(1)/2+rng_mn+rng_rng/4;
thx2 = rng_rng*rand(1)/2+rng_mn+rng_rng/4;

ids1 = x1>thx1;
ids2 = x2>thx2;
cls = (ids1&ids2)|(~ids1&~ids2);
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
title('Perceptr\''on simple (Epoca = 0, MSE = $\infty$)', 'Interpreter', 'latex');
hold off;
pause(0.1);

vw = rand(4,1);
nep = 200;
n_ap = 1/abs(max([x1;x2;x1.*x2]))-eps;
vMSE = zeros(1,nep);
im = cell(nep, 1);
nep_mx = nep;
frame = getframe(fig1);
im{1} = frame2im(frame);
for i1=1:nep
    u = [x1 x2 x1.*x2 ones(nm,1)]*vw;
    fu = u>=0;
    err = cls-fu;
    vMSE(i1) = sqrt(err'*err)/nm;
    id_err = err~=0;

    y1 = [x1o(:) x2o(:) x1o(:).*x2o(:) ones(rng_n*rng_n,1)]*vw;
    m3o(:) = y1(:)>=0;

    dvw = n_ap*([x1'; x2'; (x1.*x2)'; ones(1,nm)]*err);
    vw = vw+dvw;

    if i1>2
        if (vMSE(i1)==0)&&(vMSE(i1-1)>0)
            nep_mx = i1;
        end
    end

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
    title(sprintf('Perceptr\''on simple (Epoca = %d, MSE = %.4f)', i1, vMSE(i1)), ...
        'Interpreter', 'latex');
    hold off;
    pause(0.1);
    frame = getframe(fig1);
    im{i1+1} = frame2im(frame);
end

filename = 'testAnimated.gif';
for idx = 1:(nep_mx+1)
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
title('Grafica de desempe\~no para un perceptr\''on simple ($x\_{1}$, $x\_{2}$, $x\_{1}\cdot x\_{2}$)', ...
    'Interpreter', 'latex');
print('-f2', '-djpeg90', '-r300', 'Desempeno.jpg')