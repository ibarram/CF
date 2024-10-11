function dy = dsigmoide(u, vp)

y = 1./(1+exp(-u));
dy = y.*(1-y);