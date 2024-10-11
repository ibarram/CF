function dy = dlineal(u, vp)

np = length(vp);
[nm, nn] = size(u);
if np==2
    dy = vp(1).*ones(nm, nn);
else
    dy = [];
end