clear all
close all
clc
img = rgb2gray(imread('images/img-22.jpg'));
figure(1);
imagesc(img); axis image; colormap gray; title("IMMAGINE DI PARTENZA");hold on;

count=1;
for NoP=1:5   %in questo ciclo aumento il numero di campioni da prendere 
      for radius=1:5 %aumento il raggio x operazione morfologica
          for prC=1:5 %aumento percentile 
               mask{count}=fMask(img,NoP*10,15,15,radius,prC*10,i);
               count=count+1;
          end
      end   
end

[R C]=size(mask{1});
maskfinal=zeros(R,C);

%sommo tutte le matrici insieme
for i=1:length(mask)
    maskfinal=maskfinal+mask{i};
end


%conto il numero valori >1 nella matrice
notZero=0;
for i=1:R
    for j=1:C
        if(maskfinal(i,j)>1)
            notZero=notZero+1;
        end
    end
end

%valore medio del pixel
media=sum(maskfinal,'all')/notZero;

%setto pixel in base alla media
maskfinal(maskfinal < media) = 0;
maskfinal(maskfinal >= media) = 1;
figure(6);

imagesc(maskfinal);
title ('Maschera finale ')

A=img;
R= 15;
C = 15;

% Modifico l'immagine di partenza A in modo che abbia dimensioni uguali alla
% cross-correlazione
A = A(ceil(R/2):end-floor(R/2),ceil(C/2):end-floor(C/2)); %499x499

% Creo una nuova immagine A1, uguale ad A. I pixel che sono pari a 1 nella variabile
% mask2 devono essere messi a 255 in A1
A1 = A;
A1(maskfinal==1)=255;

% Visualizzo a lato immagine A e immagine con il difetto evidenziato in rosso
Af = cat(3,A1,A,A);
figure;
imshowpair(A,Af,'montage')
title ('Immagine e Difetto finale')

