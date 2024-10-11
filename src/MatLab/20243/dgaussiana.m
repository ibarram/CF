function dy = dgaussiana(u, vp)

np = length(vp);
if np==2
    y = exp(-((u-vp(1)).^2)/vp(2)^2);
    dy = -2*(u-vp(1)).*y./vp(2).^2;
else
    dy = [];
end