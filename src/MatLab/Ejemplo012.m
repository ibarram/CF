clc;
close all;
clear;

if ispc
    file_img = 'C:\Users\ibarr\Dropbox\DICIS\Materias\ComputacionFlexible\Codigo\CF\bd\RGGB\Frutas01r_rggb.jpg';
else
    file_img = '/Users/ibarram/Library/CloudStorage/Dropbox/DICIS/Materias/ComputacionFlexible/Codigo/CF/bd/RGGB/Frutas01r_rggb.jpg';
end
img_RGGB = imread(file_img, 'JPEG');
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

%% Bilineal
img_R = zeros(lv, lu, 'double');
img_G = zeros(lv, lu, 'double');
img_B = zeros(lv, lu, 'double');

% Color rojo
img_R(1:2:lv, 1:2:lu) = double(img_RGGB(1:2:lv, 1:2:lu));
img_R(1:2:lv, 2:2:(lu-2)) = (img_R(1:2:lv, 1:2:(lu-2))+img_R(1:2:lv, 3:2:lu))/2;
img_R(2:2:(lv-2), 1:lu) = (img_R(1:2:(lv-2), 1:lu)+img_R(3:2:lv, 1:lu))/2;

% Color verde
img_G(1:2:lv, 2:2:lu) = double(img_RGGB(1:2:lv, 2:2:lu));
img_G(2:2:lv, 1:2:lu) = double(img_RGGB(2:2:lv, 1:2:lu));
img_G(1:2:lv, 3:2:lu) = (img_G(1:2:lv, 2:2:(lu-1))+img_G(1:2:lv, 4:2:lu))/2;
img_G(2:2:lv, 2:2:(lu-2)) = (img_G(2:2:lv, 1:2:(lu-2))+img_G(2:2:lv, 3:2:lu))/2;

% Color azul
img_B(2:2:lv, 2:2:lu) = double(img_RGGB(2:2:lv, 2:2:lu));
img_B(2:2:lv, 3:2:lu) = (img_B(2:2:lv, 2:2:(lu-1))+img_B(2:2:lv, 4:2:lu))/2;
img_B(3:2:lv, 1:lu) = (img_B(2:2:(lv-1), 1:lu)+img_B(4:2:lv, 1:lu))/2;

img_RGB3 = zeros(lv, lu, 3, 'uint8');
img_RGB3(:,:,1) = uint8(img_R);
img_RGB3(:,:,2) = uint8(img_G);
img_RGB3(:,:,3) = uint8(img_B);

%% Bicubico
imgRGGBd = double(img_RGGB);
imgRGB1 = zeros(lv, lu);
imgRGB1(:,4:end-3)=(-imgRGGBd(:,1:end-6)+9*imgRGGBd(:,3:end-4)+9*imgRGGBd(:,5:end-2)-imgRGGBd(:,7:end))/16;

img_R = zeros(lv, lu, 'double');
img_G = zeros(lv, lu, 'double');
img_B = zeros(lv, lu, 'double');

img_R(1:2:lv, 1:2:lu) = imgRGGBd(1:2:lv, 1:2:lu);
img_R(1:2:lv, 2:2:lu) = imgRGB1(1:2:lv, 2:2:lu);
img_G(1:2:lv, 2:2:lu) = imgRGGBd(1:2:lv, 2:2:lu);
img_G(2:2:lv, 1:2:lu) = imgRGGBd(2:2:lv, 1:2:lu);
img_G(1:2:lv, 1:2:lu) = imgRGB1(1:2:lv, 1:2:lu);
img_G(2:2:lv, 2:2:lu) = imgRGB1(2:2:lv, 2:2:lu);
img_B(2:2:lv, 2:2:lu) = imgRGGBd(2:2:lv, 2:2:lu);
img_B(2:2:lv, 1:2:lu) = imgRGB1(2:2:lv, 1:2:lu);

imgRGB2 = zeros(lv, lu);
imgRGB3 = zeros(lv, lu);
imgRGB2(1:2:lv,:) = img_R(1:2:lv,:);
imgRGB2(2:2:lv,:) = img_B(2:2:lv,:);
imgRGB3(4:end-3,:)=(-imgRGB2(1:end-6,:)+9*imgRGB2(3:end-4,:)+9*imgRGB2(5:end-2,:)-imgRGB2(7:end,:))/16;

img_R(2:2:lv,:) = imgRGB3(2:2:lv,:);
img_B(1:2:lv,:) = imgRGB3(1:2:lv,:);

img_RGB4 = zeros(lv, lu, 3, 'uint8');
img_RGB4(:,:,1) = uint8(img_R);
img_RGB4(:,:,2) = uint8(img_G);
img_RGB4(:,:,3) = uint8(img_B);

%% Grafica de imagenes
figure(1);
imshow(img_RGGB);

figure(2);
imshow(img_RGB);

figure(3);
imshow(img_RGB2);

figure(4);
imshow(img_RGB3);

figure(4);
imshow(img_RGB4);