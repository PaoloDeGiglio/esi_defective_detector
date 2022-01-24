%% PULIZIA BUFFER
clear all
close all
clc
%% SELEZIONE IMMAGINE
% ---- Dove sono tutte le immagini da testare
path_directory='images'; % 'Folder name'
original_files=dir([path_directory '/*.jpg']); 

% ---- Impostazioni per utente
user_choice=input('-[rand] -> seleziona randomicamente un campione\n-[altro] -> selezione immagine specificata;\nScrivi qui: ','s');

if(strcmp(user_choice, "rand"))
filename=[path_directory '/' original_files(randi(length(original_files))).name];
img = rgb2gray(imread(filename));
else 
[file,path] = uigetfile({'*.jpg'}, 'Seleziona una foto',['images']);
img = rgb2gray(imread(strcat(path,file)));
end
%% STAMPA IMMAGINE DI PARTENZA

figure(1);
imagesc(img); axis image; colormap gray; title("IMMAGINE DI PARTENZA");hold on;

%% SELEZIONE DIMENSIONE PATTERN

%% SELEZIONE PATTERN SECONDO I VARI APPROCCI

%% CROSSCORRELAZIONE MASCHERE

%% EROSIONE MORFOLOGICA MASCHERE

%% STAMPA RISULTATI

%% MASCHERA MEDIA E RISULTATO MEDIO
count=1;
for NoP=1:5   %in questo ciclo aumento il numero di campioni da prendere 
      for radius=1:3 %aumento il raggio x operazione morfologica
          for prC=1:10 %aumento percentile 
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

%% RISULTATO OTTIMALE


