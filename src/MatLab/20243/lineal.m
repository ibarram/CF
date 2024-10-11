function y = lineal(u, vp)

np = length(vp);
if np==2
    y = vp(1).*u+vp(2);
else
    y = [];
end