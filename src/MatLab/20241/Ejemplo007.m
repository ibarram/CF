clc;
close all;
clear;

du = 0.01;
u_min = -10;
u_max = 10;
u = u_min:du:u_max;

m = 2;
s = 1.5;
a = -3;
b = 3;

fu1 = 1./(1+exp(-u));
fu2 = tanh(u);
fu3 = exp(-((u-m).^2)./s.^2);
fu4 = 2*atan(u)/pi;
fu5 = max(0, u);
fu6 = a*u+b;

figure('Units', 'normalized', 'Position', [0.1 0.1 0.8 0.8]);
subplot(3, 2, 1);
plot(u, fu1, 'r', 'LineWidth', 2);
title('Sigmoide');
grid on;
subplot(3, 2, 2);
plot(u, fu2, 'r', 'LineWidth', 2);
grid on;
title('Tangente hiperbolica');
subplot(3, 2, 3);
plot(u, fu3, 'r', 'LineWidth', 2);
grid on;
title('Gausiana');
subplot(3, 2, 4);
plot(u, fu4, 'r', 'LineWidth', 2);
grid on;
title('Tangente inversa');
subplot(3, 2, 5);
plot(u, fu5, 'r', 'LineWidth', 2);
grid on;
title('ReLU');
subplot(3, 2, 6);
plot(u, fu6, 'r', 'LineWidth', 2);
grid on;
title('Lineal');