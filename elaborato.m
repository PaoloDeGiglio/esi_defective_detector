%% Esercizio 2 - Cross-correlazione 2D normalizzata per trovare difetti su tessuti
clear all
close all
clc

% Carico immagine e la converto in scala di grigi
A = rgb2gray(imread('images/img-1.jpg'));
[M,N] = size(A);

% Definisco una serie di pattern, tutti quadrati 14x14
R = 14;
C = 14; 
pattern1 = A(1:R,1:C); 
pattern2 = A(2:R+1,2:C+1); 
pattern3 = A(M-13:M,N-13:N);
pattern4 = A(M-14:M-1,N-14:N-1);
pattern5 = A(1:R,N-13:N);
pattern6 = A(2:R+1,N-13:N);

% Visualizzo i pattern sovrapposti all'immagine di partenza (convertita in
% scala di grigi)
figure;
imagesc(A); axis image; colormap gray; hold on;
title ('Tessitura e pattern sovrapposti')
rectangle('position',[1,1,R,C],'EdgeColor','r'); % pattern1
rectangle('position',[2,2,R,C],'EdgeColor','g'); % pattern2
rectangle('position',[M-13,N-13,14,14],'EdgeColor','b'); % pattern3
rectangle('position',[M-14,N-14,14,14],'EdgeColor','c'); % pattern4
rectangle('position',[1,N-13,14,14],'EdgeColor','m'); % pattern5
rectangle('position',[2,N-13,14,14],'EdgeColor','k'); % pattern6

% Calcolo per ogni pattern la cross-correlazione 2D (normalizzata). Attenzione all'ordine delle variabili in input! 
% L'output avra' dimensione (M+R-1,N+C-1)
% From MATLAB Help:
% C = normxcorr2(TEMPLATE,A) computes the normalized cross-correlation of
%     matrices TEMPLATE and A. The matrix A must be larger than the matrix
%     TEMPLATE for the normalization to be meaningful. The values of TEMPLATE
%     cannot all be the same. The resulting matrix C contains correlation
%     coefficients and its values may range from -1.0 to 1.0.

c1 = normxcorr2(pattern1,A); 
c2 = normxcorr2(pattern2,A);
c3 = normxcorr2(pattern3,A);
c4 = normxcorr2(pattern4,A);
c5 = normxcorr2(pattern5,A);
c6 = normxcorr2(pattern6,A);

% Calcolo la cross-correlazione media, che avra' sempre dimensione (M+R-1,N+C-1) 
c = (c1+c2+c3+c4+c5+c6)/6; % 525x525

% Considero solo la parte di cross-correlazione che e' stata eseguita senza 
% gli zero-padded edges, in modo da rimuovere effetto bordo. Quindi l'output
% avra' dimensioni (M-R+1, N-C+1)
% Hint: matrice_xcorr_reduced = matrice_xcorr(r:(end-r+1),c:(end-c+1));
c = c(R:end-R+1,C:end-C+1); % 499x499

% Visualizzo, in un subplot con due riquadri, il valore assoluto della
% cross-correlazione appena stimata sia come surface plot che come immagine
figure, subplot(121), surf(abs(c)), shading flat
title ('Xcorr2D - Surface Plot')
subplot(122), imagesc(abs(c)), axis 'image', colorbar
title ('Xcorr2D - Immagine')

% Faccio il modulo della cross-correlazione appena stimata, su cui
% lavorero' da qui in avanti
c=abs(c);

% A partire dalla cross-correlazione stimata, creo una maschera
% selezionando tutti i valori inferiori a 0.2 e la visualizzo 
mask = c<0.2;
figure, imagesc(mask)
title ('Maschera 1')

% Creo come elemento strutturale un disco con raggio = 3, da utilizzare poi per eseguire 
% una operazione morfologica di apertura (hint: utilizzare i comandi strel e imopen)
% Il risultato deve essere una variabile chiamata mask2, che va poi
% visualizzata in una nuova figura
% Nota per IMOPEN = Perform morphological opening.
% The opening operation erodes an image and then dilates the eroded image,
% using the same structuring element for both operations.
% Morphological opening is useful for removing small objects from an image
% while preserving the shape and size of larger objects in the image.

se = strel('disk',3,0); 
mask2 = imopen(mask,se);
figure, imagesc(mask2);
title ('Maschera 2 dopo operazione morfologica')

% Modifico l'immagine di partenza A in modo che abbia dimensioni uguali alla
% cross-correlazione 
A = A(ceil(R/2):end-floor(R/2),ceil(C/2):end-floor(C/2)); %499x499

% Creo una nuova immagine A1, uguale ad A. I pixel che sono pari a 1 nella variabile
% mask2 devono essere messi a 255 in A1 
A1 = A;
A1(mask2)=255;

% Visualizzo a lato immagine A e immagine con il difetto evidenziato in rosso  
Af = cat(3,A1,A,A);
figure;
%imshowpair(A,Af,'montage')
imagesc(Af);
imagesc(A);
title ('Immagine e Difetto finale')

