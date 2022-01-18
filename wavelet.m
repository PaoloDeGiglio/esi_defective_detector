clear all
close all
clc
ORIG = rgb2gray(imread('images/img-6.jpg'));
figure(1);
imagesc(ORIG); axis image; colormap gray; title("IMMAGINE DI PARTENZA");hold on;

val = histeq(ORIG);
figure(1);
imagesc(val); axis image; colormap gray; title("IMMAGINE DI PARTENZA");hold on;
figure(2)
subplot(1,2,1)
imhist(ORIG);
subplot(1,2,2)
imhist(val);

imgmedfilt = medfilt2(val);

[c,s] = wavedec2(imgmedfilt, 2, 'haar');

[H1,V1,D1] = detcoef2('all',c,s,1);
A1 = appcoef2(c,s,'haar',1);

V1img = wcodemat(V1,255,'mat',1);
H1img = wcodemat(H1,255,'mat',1);
D1img = wcodemat(D1,255,'mat',1);
A1img = wcodemat(A1,255,'mat',1);

subplot(2,2,1)
imagesc(A1img)
title('Approximation Coef. of Level 1')

subplot(2,2,2)
imagesc(H1img)
title('Horizontal Detail Coef. of Level 1')

subplot(2,2,3)
imagesc(V1img)
title('Vertical Detail Coef. of Level 1')

subplot(2,2,4)
imagesc(D1img)
title('Diagonal Detail Coef. of Level 1')


