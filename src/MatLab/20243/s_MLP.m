function y = s_MLP(MLP, X)

nc = length(MLP);
y = X;
for i1=1:nc
    u = y*(MLP{i1}.W)';
    y = MLP{i1}.fa(u);
end