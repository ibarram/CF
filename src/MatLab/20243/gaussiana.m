function y = gaussiana(u, vp)

np = length(vp);
if np==2
    y = exp(-((u-vp(1)).^2)/vp(2)^2);
else
    y = [];
end