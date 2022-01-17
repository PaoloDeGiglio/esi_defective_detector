clear all
close all
clc
ORIG = rgb2gray(imread('images/tex.jpg'));
figure(1);
imagesc(ORIG); axis image; colormap gray; title("IMMAGINE DI PARTENZA");hold on;

main(ORIG,20,2);
main(ORIG,50,3);
main(ORIG,100,4);