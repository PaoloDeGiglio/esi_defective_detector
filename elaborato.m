clear all
close all
clc
ORIG = rgb2gray(imread('images/img-22.jpg'));
figure(1);
imagesc(ORIG); axis image; colormap gray; title("IMMAGINE DI PARTENZA");hold on;

mask1 = main(ORIG,20,2);
mask2 = main(ORIG,20,3);
mask3 = main(ORIG,20,4);
mask4 = main(ORIG,20,5);

%maskfinal = zeros(size(mask1));
maskfinal = mask1 + mask2 + mask3 + mask4;
maskfinal(maskfinal >= 2) = 1;
figure(6);
A = ORIG;
A1 = ORIG;
A1(maskfinal)=255;

% Visualizzo a lato immagine A e immagine con il difetto evidenziato in rosso
Af = cat(3,A1,A,A);
imshowpair(A,Af,'montage')
title ('Immagine e Difetto finale')

%main(ORIG,50,3);
%main(ORIG,100,4);