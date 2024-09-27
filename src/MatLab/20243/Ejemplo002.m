clc;
close all
clear;

md = [5 10; 4 6]; % [mdx1, my1; mx2 my2]
sd = [1.2 1.4; .9 1.3]; % [sdx1 sdy1, sdx2, sdy2]
nc1 = 100;
nc2 = 150;
n = nc1+nc2;

%% Clase 1, de uniforma a normal por Box-Muller
U1 = rand(nc1, 2);
Z1(:,1) = sqrt(-2*log(U1(:,1))).*cos(2*pi*U1(:,2));
Z1(:,2) = sqrt(-2*log(U1(:,1))).*sin(2*pi*U1(:,2));
X1 = Z1.*(ones(nc1,1)*sd(1,:))+ones(nc1,1)*md(1,:);

%% Clase 2, de uniforma a norla por Box-Muller
U2 = rand(nc2, 2);
Z2(:,1) = sqrt(-2*log(U2(:,1))).*cos(2*pi*U2(:,2));
Z2(:,2) = sqrt(-2*log(U2(:,1))).*sin(2*pi*U2(:,2));
X2 = Z2.*(ones(nc2,1)*sd(2,:))+ones(nc2,1)*md(2,:);


%% Generación de muestras
X = [X1 zeros(nc1,1);X2 ones(nc2,1)];
nX = size(X);
fa = (1/max(max(abs(X(:,1:(nX(2)-1))))))/5e2;
ni_max = 1e6;

W = rand(nX(2),1);

mX = 100;
vX1 = min(X(:,1)):((max(X(:,1))-min(X(:,1)))/mX):max(X(:,1));
vX2 = min(X(:,2)):((max(X(:,2))-min(X(:,2)))/mX):max(X(:,2));
mX1 = ones(mX+1,1)*vX1;
mX2 = vX2'*ones(1,mX+1);
mXt = [mX1(:) mX2(:)];
mY = zeros(mX+1,mX+1);

SSEy = zeros(ni_max,1);
figure(1);
for i1=1:ni_max
    u = [X(:, 1:(nX(2)-1)) ones(nX(1), 1)]*W;
    y = 1./(1+exp(-u));
    u1 = [mXt ones((mX+1)*(mX+1), 1)]*W;
    mY(:) = 1./(1+exp(-u1));

    surf(vX1,vX2,mY)
    hold on;
    plot3(X1(:,1), X1(:,2), zeros(nc1,1), 'ro', 'MarkerSize', 10);
    hold on;
    plot3(X2(:,1), X2(:,2), ones(nc2,1), 'bs', 'MarkerSize', 10);
    grid on;
    hold off;

    e = (X(:,end)-y);
    SSEy(i1) = e'*e;
    W = W+fa*([X(:, 1:(nX(2)-1)) ones(nX(1), 1)]'*(e.*y.*(1-y)));
    pause(0.1);
end