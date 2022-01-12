%% Esercizio 2 - Cross-correlazione 2D normalizzata per trovare difetti su tessuti
clear all
close all
clc

% Carico immagine e la converto in scala di grigi
A = rgb2gray(imread('images/tex.jpg'));
[M,N] = size(A);

% Dimensione dei miei quadratini
R = 15;
C = 15; 

%incidici di partenza dei miei quadratini
x=1;
y=1;

dimPattern=0;
i=1;
incX=ceil((N-R)/(ceil((N/R))/2)); %Lunghezza riga / numero quadratini per ogni riga/2
incY=ceil((M-C)/(ceil((M/C))/2));
while (y+C<N)   %controllo di non uscire dall'ultima riga
    if(x+R<N) %controllo se devo cambiare riga
            pattern{i}.img=A(x:x+R-1, y:y+C-1);
            pattern{i}.basex=x;
            pattern{i}.basey=y;
            pattern{i}.endx=x+R-1;
            pattern{i}.endy=y+C-1;
            pattern{i}.dimx=R;
            pattern{i}.dimy=C;
            x=x+incX; %sposto a dx il quadratino di un valore fisso 
       else
            x=1;
            y=y+incY; %abbasso il quadratino di un valore fisso
            if(y+C<M)   %se non esco allora mi salvo il quadratino
                pattern{i}.img=A(x:x+R-1, y:y+C-1);
                pattern{i}.basex=x;
                pattern{i}.basey=y;
                pattern{i}.endx=x+R-1;
                pattern{i}.endy=y+C-1;
                pattern{i}.dimx=R;
                pattern{i}.dimy=C;
            end
    end
        dimPattern=dimPattern+1;
        i=i+1;
end
dimPattern=dimPattern-1; %sistemo contatore

% Visualizzo i pattern sovrapposti all'immagine di partenza (convertita in
% scala di grigi)
figure;
imagesc(A); axis image; colormap gray; hold on;
title ('Tessitura e pattern sovrapposti')
 
%stampo i pattern sull'immagine
for i=1:dimPattern
    rectangle('position',[pattern{i}.basex,pattern{i}.basey,pattern{i}.dimx,pattern{i}.dimy],'EdgeColor','r');  
end

% Calcolo per ogni pattern la cross-correlazione 2D (normalizzata). Attenzione all'ordine delle variabili in input! 
% L'output avra' dimensione (M+R-1,N+C-1)
sumC=zeros(M+R-1,N+C-1);
for i=1:dimPattern
    correlazione{i}=normxcorr2(pattern{i}.img,A);
    sumC=sumC+correlazione{i};  %sommo tutte le correlazioni 
end

% Calcolo la cross-correlazione media, che avra' sempre dimensione (M+R-1,N+C-1) 
cMedia=sumC/dimPattern;

% Considero solo la parte di cross-correlazione che e' stata eseguita senza 
% gli zero-padded edges, in modo da rimuovere effetto bordo. Quindi l'output
% avra' dimensioni (M-R+1, N-C+1)
% Hint: matrice_xcorr_reduced = matrice_xcorr(r:(end-r+1),c:(end-c+1));
cMedia = cMedia(R:end-R+1,C:end-C+1); % 499x499

% Visualizzo, in un subplot con due riquadri, il valore assoluto della
% cross-correlazione appena stimata sia come surface plot che come immagine
figure, subplot(121), surf(abs(cMedia)), shading flat
title ('Xcorr2D - Surface Plot')
subplot(122), imagesc(abs(cMedia)), axis 'image', colorbar
title ('Xcorr2D - Immagine')

% Faccio il modulo della cross-correlazione appena stimata, su cui
% lavorero' da qui in avanti
cMedia=abs(cMedia);

% A partire dalla cross-correlazione stimata, creo una maschera
% selezionando tutti i valori inferiori a 0.2 e la visualizzo 
mask = cMedia<prctile(cMedia,25,'all');
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
imshowpair(A,Af,'montage')
title ('Immagine e Difetto finale')
