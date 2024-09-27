clc;
close all;
clear;

tb = readtable('https://raw.githubusercontent.com/ibarram/CF/main/bd/diabetes.csv');
data = table2array(tb);

[nmt, nf] = size(data);
id_v = [2, 3, 4, 5, 6];
nid_v = length(id_v);
iv = true(nmt, 1);
for i1=1:nid_v
    i2 = (data(:,id_v(i1)) ~= 0);
    iv = iv&i2;
end
niv = sum(iv);

entrada = data(iv, 1:(nf-1));
%{
entrada_r = data(iv, 1:(nf-1));
m_ent = mean(entrada_r);
s_ent = std(entrada_r);
entrada = (entrada_r-ones(niv, 1)*m_ent)./(ones(niv, 1)*s_ent);
%}
salida = data(iv, nf);clc

is0 = find(salida==0);
nis0 = length(is0);
is1 = find(salida==1);
nis1 = length(is1);
nis = nis1;
if(nis0>nis1)
    nis = nis1;
    ir = randperm(nis0);
    is0 = is0(ir(1:nis));
elseif(nis0<nis1)
    ir = randperm(nis1);
    is1 = is1(ir(1:nis));
    nis = nis0;
end

nm = 2*nis;
n_ep = 200000;

%n_ap = 1/abs(max([x1;x2]))-eps;
n_ap = 5e-6;

cls = salida([is0;is1]);
id0 = cls==0;
id1 = ~id0;

x = entrada([is0;is1],:);

S_MLP = [3, 5, 1];
FA_MLP = {@fa_th, @fa_s, @fa_s; @dfa_th, @dfa_s, @dfa_s;};
MLP1 = crear_MLP(x, S_MLP, FA_MLP);

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

MLP2 = cell(nc,1);
for i1=1:nc
    MLP2{i1} = MLP1{i1};
end
y1 = sim_MLP(x, MLP2);

plot(MSE_1)
SAE_1