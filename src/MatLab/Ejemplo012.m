clc;
close all;
clear;

file_img = '/Users/ibarram/Dropbox/DICIS/Materias/ComputacionFlexible/bd/RGGB/Frutas01r_rggb.jpg';
img_RGGB = imread(file_img);
[lv, lu] = size(img_RGGB);

%% Proximos vecinos
% Color rojo
img_R = zeros(lv, lu, 'uint8');
% Pixel rojo
img_R(1:2:lv, 1:2:lu) = img_RGGB(1:2:lv, 1:2:lu);
% Vecino de la derecha
img_R(1:2:lv, 2:2:lu) = img_RGGB(1:2:lv, 1:2:lu);
% Vecino inferior
img_R(2:2:lv, 1:2:lu) = img_RGGB(1:2:lv, 1:2:lu);
% Vecino de la diagonal
img_R(2:2:lv, 2:2:lu) = img_RGGB(1:2:lv, 1:2:lu);

% Color azul
img_B = zeros(lv, lu, 'uint8');
% Pixel azul
img_B(2:2:lv, 2:2:lu) = img_RGGB(2:2:lv, 2:2:lu);
% Vecino de la izquierda
img_B(2:2:lv, 1:2:lu) = img_RGGB(2:2:lv, 2:2:lu);
% Vecino superior
img_B(1:2:lv, 2:2:lu) = img_RGGB(2:2:lv, 2:2:lu);
% Vecino en diagonal
img_B(1:2:lv, 1:2:lu) = img_RGGB(2:2:lv, 2:2:lu);

% Color Verde
img_G = zeros(lv, lu, 'uint8');
% Pixel verde superior
img_G(1:2:lv, 2:2:lu) = img_RGGB(1:2:lv, 2:2:lu);
% Pixel  de la izquierda
img_G(1:2:lv, 1:2:lu) = img_RGGB(1:2:lv, 2:2:lu);
% Pixel verde inferior
img_G(2:2:lv, 1:2:lu) = img_RGGB(2:2:lv, 1:2:lu);
% Pixel de la derecha
img_G(2:2:lv, 2:2:lu) = img_RGGB(2:2:lv, 1:2:lu);

img_RGB = zeros(lv, lu, 3, 'uint8');
img_RGB(:,:,1) = img_R;
img_RGB(:,:,2) = img_G;
img_RGB(:,:,3) = img_B;

%% Lineal
% Color rojo
img_R = img_RGGB(1:2:lv, 1:2:lu);
% Color verde
img_G1 = double(img_RGGB(1:2:lv, 2:2:lu));
img_G2 = double(img_RGGB(2:2:lv, 1:2:lu));
img_G = uint8((img_G1+img_G2)/2);
% Color azul
img_B = img_RGGB(2:2:lv, 2:2:lu);

img_RGB2 = zeros(lv/2, lu/2, 3, 'uint8');
img_RGB2(:,:,1) = img_R;
img_RGB2(:,:,2) = img_G;
img_RGB2(:,:,3) = img_B;

%% Grafica de imagenes
figure(1);
imshow(img_RGGB);

figure(2);
imshow(img_RGB);

figure(3);
imshow(img_RGB2);