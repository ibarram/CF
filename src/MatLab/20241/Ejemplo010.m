clc;
close all;
clear;

rng_mx = 10;
rng_mn = -10;
nm = 100;
n_ep = 500000;

x1 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
x2 = (rng_mx-rng_mn)*rand(nm, 1)+rng_mn;
xo = sort(x1);

%n_ap = 1/abs(max([x1;x2]))-eps;
n_ap = 1e-4;

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

S_MLP = [3, 5, 1];
FA_MLP = {@fa_th, @fa_s, @fa_s; @dfa_th, @dfa_s, @dfa_s;};
MLP1 = crear_MLP(x, S_MLP, FA_MLP);
y1 = sim_MLP(x, MLP1);
yc = y1>0.5;
verr = (cls-yc);
MSE_1 = sqrt(sum(verr.^2))/nm;
id_err = verr~=0;

hold on;
plot(x1(id_err), x2(id_err), 'g*');
hold off;

nc = length(MLP1);
ne = size(x,2);
MSE_1 = zeros(1, n_ep);
for i1=1:n_ep
    if (size(MLP1{1}.W,1)-1)~=ne
        cls_ob = [];
        break;
    end
    MLP1{1}.fu = [x ones(nm,1)];
    for i2=1:nc
        MLP1{i2}.u = MLP1{i2}.fu*MLP1{i2}.W;
        MLP1{i2+1}.fu = [MLP1{i2}.fA(MLP1{i2}.u) ones(nm,1)];
    end
    cls_ob = MLP1{nc+1}.fu(:,1:(end-1));
    verr = cls-cls_ob;
    derr = verr;
    MLP1{nc}.dt = derr.*(MLP1{nc}.dfA(MLP1{nc+1}.fu(:,1)));
    %MLP1{2}.dt = [MLP1{2}.dfA(MLP1{3}.fu(:,1:S_MLP(2))) ones(nm, 1)].*(MLP1{3}.dt*MLP1{3}.W');

    %MLP1{2}.dt = MLP1{2}.dfA(MLP1{3}.fu(:,1:S_MLP(2))).*(MLP1{3}.dt*MLP1{3}.W(1:S_MLP(2),:)');
    %MLP1{1}.dt = MLP1{1}.dfA(MLP1{2}.fu(:,1:S_MLP(1))).*(MLP1{2}.dt*MLP1{2}.W(1:S_MLP(1),:)');
    for i2=(nc-1):-1:1
        MLP1{i2}.dt = MLP1{i2}.dfA(MLP1{i2+1}.fu(:,1:S_MLP(i2))).*(MLP1{i2+1}.dt*MLP1{i2+1}.W(1:S_MLP(i2),:)');
    end

    for i2=1:nc
        if i2==1
            N_en = ne+1;
        else
            N_en = S_MLP(i2-1)+1;
        end
        MLP1{i2}.W = MLP1{i2}.W+n_ap*(sum(MLP1{i2}.fu.*(MLP1{i2}.dt*ones(S_MLP(i2),N_en))))';
    end

    MSE_1(i1) = sqrt(sum(verr.^2))/nm;
end

SAE_1 = sum(abs((MLP1{nc+1}.fu(:,1)>0.5)-cls))/nm;

plot(MSE_1)
SAE_1