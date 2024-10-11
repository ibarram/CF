function MLP = c_MLP(ne, nvp, fa, vp)

nc = length(nvp);
nvp = [ne, nvp];

MLP = cell(nc, 1);
for i1=1:nc
    MLP{i1}.W = rand(nvp(i1+1), nvp(i1));
    MLP{i1}.t = rand(nvp(i1+1), 1);
    MLP{i1}.fa = fa{i1};
    MLP{i1}.vp = vp{i1};
end
