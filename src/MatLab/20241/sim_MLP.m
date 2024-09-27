function y = sim_MLP(x, MLP1)

[nm, ne] = size(x);
nc = length(MLP1);

if (size(MLP1{1}.W,1)-1)~=ne
    y = [];
    return
end

fu = [x ones(nm,1)];
for i1=1:nc
    u = fu*MLP1{i1}.W;
    fu = [MLP1{i1}.fA(u) ones(nm,1)];
end
y = fu(:,1:(end-1));