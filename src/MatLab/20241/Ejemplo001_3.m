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

fig1 = figure('Units', 'normalized', ...
    'Position', [0.1 0.1 0.8 0.8]);
plot(x1(id0), x2(id0), 'ro');
hold on;
plot(x1(id1), x2(id1), 'ks');
axis([rng_mn, rng_mx, rng_mn, rng_mx]);
xlabel('x_1');
ylabel('x_2');
grid on;
title('Perceptr\''on simple (Epoca = 0, MSE = $\infty$)', 'Interpreter', 'latex');
legend('Muestras clase 0', 'Muestras clase 1', ...
    'Location','southeast', 'Interpreter','latex',...
    'FontSize',14);
hold off;
pause(0.1);

vw = rand(3,1);
nep = 100;
n_ap = 1/abs(max([x1;x2]))-eps;
mu = 0.7;
vw1 = vw;
avw1 = vw1;
vMSE = zeros(1,nep);
vMSE1 = zeros(1,nep);

im = cell(nep, 1);
nep_mx = nep;
frame = getframe(fig1);
im{1} = frame2im(frame);

for i1=1:nep
    u = [x1 x2 ones(nm,1)]*vw;
    fu = u>=0;
    err = cls-fu;
    vMSE(i1) = sqrt(err'*err)/nm;
    id_err = err~=0;

    u1 = [x1 x2 ones(nm,1)]*vw1;
    fu1 = u1>=0;
    err1 = cls-fu1;
    vMSE1(i1) = sqrt(err1'*err1)/nm;
    id_err1 = err1~=0;
    
    y1 = -xo*vw(1)/vw(2)-vw(3)/vw(2);
    dvw = n_ap*([x1'; x2'; ones(1,nm)]*err);
    vw = vw+dvw;

    y2 = -xo*vw1(1)/vw1(2)-vw1(3)/vw1(2);
    dvw1 = n_ap*([x1'; x2'; ones(1,nm)]*err1);
    aavw1 = avw1;
    avw1 = vw1;
    vw1 = vw1+dvw1+mu*(avw1-aavw1);

    ts1 = (vMSE(i1)==0)&&(vMSE(i1-1)>0)&&(vMSE1(i1)==0);
    ts2 = (vMSE1(i1)==0)&&(vMSE1(i1-1)>0)&&(vMSE(i1)==0);
    if i1>2
        if ts1||ts2
            nep_mx = i1;
        end
    end

    figure(1);
    plot(x1(id0), x2(id0), 'ro');
    axis([rng_mn, rng_mx, rng_mn, rng_mx])
    hold on;
    plot(x1(id1), x2(id1), 'ks');
    plot(x1(id_err), x2(id_err), 'b*');
    plot(xo, yo, 'b-');
    plot(xo, y1, 'g--');
    plot(xo, y2, 'm-.');
    xlabel('x_1');
    ylabel('x_2');
    grid on;
    title(sprintf('Perceptrón simple (Epoca = %d, MSE = %.4f)', i1, vMSE(i1)));
    if sum(id_err)>0
        legend('Muestras clase 0', 'Muestras clase 1', ...
            'Muestras mal clasificadas', 'Modelo ideal', ...
            '$\eta=\frac{1}{|\textbf{X}(k)_{max}|}$, $\mu=0$', ...
            '$\eta=\frac{1}{|\textbf{X}(k)_{max}|}$, $\mu=0.7$',...
            'Location','southeast', 'Interpreter','latex', ...
            'FontSize',14);
    else
        legend('Muestras clase 0', 'Muestras clase 1', ...
            'Modelo ideal', ...
            '$\eta=\frac{1}{|\textbf{X}(k)_{max}|}$, $\mu=0$', ...
            '$\eta=\frac{1}{|\textbf{X}(k)_{max}|}$, $\mu=0.7$', ...
            'Location','southeast', 'Interpreter','latex', ...
            'FontSize',14);
    end
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

figure('Units', 'normalized', ...
    'Position', [0.1 0.1 0.8 0.8]);
plot(1:nep_mx,vMSE(1:nep_mx),'b*-');
hold on;
plot(1:nep_mx,vMSE1(1:nep_mx),'ro-');
axis([1, nep_mx, min(vMSE), max(vMSE)]);
grid on;
ylabel('MSE');
xlabel('Epoca');
title('Grafica de desempeño para un perceptrón simple');
legend('$\eta=\frac{1}{|\textbf{X}(k)_{max}|}$, $\mu=0$', ...
    '$\eta=\frac{1}{|\textbf{X}(k)_{max}|}$, $\mu=0.7$',...
    'Location','northeast','Interpreter','latex',...
    'FontSize',14);
print('-f2', '-djpeg90', '-r300', 'Desempeno.jpg');