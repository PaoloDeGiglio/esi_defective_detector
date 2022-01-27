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
subplot(411);
imagesc(img); axis image; colormap gray; title("IMMAGINE DI PARTENZA");hold on;

%% SELEZIONE DIMENSIONE PATTERN

kernel_size = kernel_size(img);
num_kernels = 12;
kernel_size = 12;

%% SELEZIONE PATTERN SECONDO I VARI APPROCCI

kernel_standard = create_kernel(img,'standard','all',kernel_size,num_kernels);
kernel_rand_all = create_kernel(img,'random','all',kernel_size,num_kernels);
kernel_rand_vertex = create_kernel(img,'random','vertex',kernel_size,num_kernels);

%visualizzo i kernel 
subplot(422); 
imagesc(img); axis image; colormap gray; hold on;
for j=1:num_kernels
    rectangle('position',[kernel_standard{j}.basex,kernel_standard{j}.basey,kernel_standard{j}.dim,kernel_standard{j}.dim],'EdgeColor','r');
    rectangle('position',[kernel_rand_all{j}.basex,kernel_rand_all{j}.basey,kernel_rand_all{j}.dim,kernel_rand_all{j}.dim],'EdgeColor','g');
    rectangle('position',[kernel_rand_vertex{j}.basex,kernel_rand_vertex{j}.basey,kernel_rand_vertex{j}.dim,kernel_rand_vertex{j}.dim],'EdgeColor','b');
end
hold off;

%% CROSSCORRELAZIONE MASCHERE

mask_standard = create_mask(img,kernel_standard, num_kernels, kernel_size);
mask_rand_all = create_mask(img,kernel_rand_all, num_kernels, kernel_size);
mask_rand_vertex = create_mask(img,kernel_rand_vertex, num_kernels, kernel_size);

%% EROSIONE MORFOLOGICA E PERCENTILE MASCHERE

mask_standard_opt = mask_optimization(mask_standard);
mask_rand_all_opt = mask_optimization(mask_rand_all);
mask_rand_vertex_opt = mask_optimization(mask_rand_vertex);

%% STAMPA RISULTATI

subplot(423);
imagesc(mask_standard_opt);title ('Maschera standard finale ');
show_defects(img,mask_standard_opt,424)
subplot(425);
imagesc(mask_rand_all_opt);title ('Maschera randomica generica finale ');
show_defects(img,mask_standard_opt,426)
subplot(427);
imagesc(mask_rand_all_opt);title ('Maschera randomica vertitici finale ');
show_defects(img,mask_standard_opt,428)


%% MASCHERA MEDIA E RISULTATO MEDIO
% count=1;
% for NoP=1:5   %in questo ciclo aumento il numero di campioni da prendere 
%       for radius=1:3 %aumento il raggio x operazione morfologica
%           for prC=1:10 %aumento percentile 
%                mask{count}=fMask(img,NoP*10,15,15,radius,prC*10,i);
%                count=count+1;
%           end
%       end   
% end
% 
% [R C]=size(mask{1});
% maskfinal=zeros(R,C);
% 
% %sommo tutte le matrici insieme
% for i=1:length(mask)
%     maskfinal=maskfinal+mask{i};
% end
% 
% 
% %conto il numero valori >1 nella matrice
% notZero=0;
% for i=1:R
%     for j=1:C
%         if(maskfinal(i,j)>1)
%             notZero=notZero+1;
%         end
%     end
% end
% 
% %valore medio del pixel
% media=sum(maskfinal,'all')/notZero;
% 
% %setto pixel in base alla media
% maskfinal(maskfinal < media) = 0;
% maskfinal(maskfinal >= media) = 1;
% figure(6);
% 
% imagesc(maskfinal);
% title ('Maschera finale ')
% 
% A=img;
% R= 15;
% C = 15;
% 
% % Modifico l'immagine di partenza A in modo che abbia dimensioni uguali alla
% % cross-correlazione
% A = A(ceil(R/2):end-floor(R/2),ceil(C/2):end-floor(C/2)); %499x499

% Creo una nuova immagine A1, uguale ad A. I pixel che sono pari a 1 nella variabile
% mask2 devono essere messi a 255 in A1
A1 = img;
A1(maskfinal==1)=255;

% Visualizzo a lato immagine A e immagine con il difetto evidenziato in rosso
Af = cat(3,A1,A,A);
figure;
imshowpair(A,Af,'montage')
title ('Immagine e Difetto finale')

%% RISULTATO OTTIMALE


