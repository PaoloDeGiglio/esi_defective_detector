clear all
close all
clc
ORIG = rgb2gray(imread('images/tex.jpg'));
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

[H2,V2,D2] = detcoef2('all',c,s,1);
A2 = appcoef2(c,s,'haar',1);

V2img = wcodemat(V2,255,'mat',1);
H2img = wcodemat(H2,255,'mat',1);
D2img = wcodemat(D2,255,'mat',1);
A2img = wcodemat(A2,255,'mat',1);

figure(5)
subplot(2,2,1)
imagesc(A2img)
colormap pink(255)
title('Approximation Coef. of Level 2')

subplot(2,2,2)
imagesc(H2img)
title('Horizontal Detail Coef. of Level 2')

subplot(2,2,3)
imagesc(V2img)
title('Vertical Detail Coef. of Level 2')

subplot(2,2,4)
imagesc(D2img)
title('Diagonal Detail Coef. of Level 2')

level1 = graythresh(ORIG)*255;
level2 = graythresh(ORIG)*255;
level3 = graythresh(ORIG)*255;
level4 = graythresh(ORIG)*255;

BW1 = imbinarize(A2img, level1);
BW2 = imbinarize(H2img, level2);
BW3 = imbinarize(D2img, level3);
BW4 = imbinarize(V2img, level4);

figure(3);
subplot(2,2,1)
imshow(BW1)
subplot(2,2,2)
imshow(BW2)
subplot(2,2,3)
imshow(BW3)
subplot(2,2,4)
imshow(BW4)