function MLP1 = crear_MLP(x, S_MLP, FA_MLP)

nx = size(x,2);
nc = length(S_MLP);
nfa = length(FA_MLP);

if nc~=nfa
    MLP1 = [];
    return
end

MLP1 = cell(nc, 1);
for i1=1:nc
    if i1==1
        MLP1{i1}.W = 2*rand(nx+1,S_MLP(i1))-1;
    else
        MLP1{i1}.W = 2*rand(S_MLP(i1-1)+1,S_MLP(i1))-1;
    end
    MLP1{i1}.fA = FA_MLP{i1};
end