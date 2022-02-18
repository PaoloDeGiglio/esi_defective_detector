%% PULIZIA BUFFER
clear all
close all
%clc
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
imagesc(img); axis image; colormap gray; title("IMMAGINE DI PARTENZA - Seleziona il kernel");hold on;

%% SELEZIONE DIMENSIONE PATTERN

kernel_size = kernel_size(img);
num_kernels = 12;
kernel_size = 12;
number_iteration=25;
%% SELEZIONE PATTERN SECONDO I VARI APPROCCI

kernel_standard = create_kernel(img,'standard','all',kernel_size,num_kernels);
for i=1:number_iteration
kernel_rand_all{i} = create_kernel(img,'random','all',kernel_size,num_kernels);
kernel_rand_vertex{i} = create_kernel(img,'random','vertex',kernel_size,num_kernels);
end
kernel_crop=imcrop(img);    %selezione manuale kernel
%visualizzo i kernel 
figure;
title('Kernel in base alle varie impostazioni');
imagesc(img); axis image; colormap gray;title('Kernel in base alle varie impostazioni'); hold on;

%da eliminare
for j=1:num_kernels
    rectangle('position',[kernel_standard{j}.basex,kernel_standard{j}.basey,kernel_standard{j}.dim,kernel_standard{j}.dim],'EdgeColor','r');
    %rectangle('position',[kernel_rand_all{j}.basex,kernel_rand_all{j}.basey,kernel_rand_all{j}.dim,kernel_rand_all{j}.dim],'EdgeColor','g');
    %rectangle('position',[kernel_rand_vertex{j}.basex,kernel_rand_vertex{j}.basey,kernel_rand_vertex{j}.dim,kernel_rand_vertex{j}.dim],'EdgeColor','b');
end
hold off;

%% CROSSCORRELAZIONE MASCHERE

c_mask_standard= create_mask(img,kernel_standard, num_kernels, kernel_size,'');
for i=1:number_iteration
 c_mask_rand_all{i} = create_mask(img,kernel_rand_all{i}, num_kernels, kernel_size,'');
 c_mask_rand_vertex{i} = create_mask(img,kernel_rand_vertex{i}, num_kernels, kernel_size,'');
end
c_mask_crop=create_mask(img,kernel_crop, 1, size(kernel_crop),'crop');

%% EROSIONE MORFOLOGICA E PERCENTILE MASCHERE

mask_standard_opt = mask_optimization(c_mask_standard);
for i=1:number_iteration
mask_rand_all_opt{i} = mask_optimization(c_mask_rand_all{i});
mask_rand_vertex_opt{i} = mask_optimization(c_mask_rand_vertex{i});
end
mask_crop_opt=mask_optimization(c_mask_crop);

%% Calcolo valore medio maschera e tolgo maschere errate
for i=1:number_iteration
    sum_mask_rand_all_opt(i)=sum(mask_rand_all_opt{i},'all');
    sum_mask_rand_vertex_opt(i)=sum(mask_rand_vertex_opt{i},'all');
end
%quanti pixel ha mediamente la maschera
mean_mask_rand_all_opt=sum(sum_mask_rand_all_opt,'all')/number_iteration;
mean_mask_rand_vertex_opt=sum(sum_mask_rand_vertex_opt,'all')/number_iteration;

%elimino maschere sbagliate
mask_rand_vertex_opt=cleanSomeMask(mask_rand_vertex_opt,mean_mask_rand_vertex_opt,number_iteration);
mask_rand_all_opt=cleanSomeMask(mask_rand_all_opt,mean_mask_rand_all_opt,number_iteration);

%% STAMPA RISULTATI

% Calcolo la mediana delle maschere
median_mask_rand_vertex_opt=mask_rand_vertex_opt{1};
median_mask_rand_all_opt=mask_rand_all_opt{1};
for i=2:numel(mask_rand_vertex_opt)
median_mask_rand_vertex_opt = cat(3,median_mask_rand_vertex_opt,mask_rand_vertex_opt{i});
end

for i=2:numel(mask_rand_all_opt)
 median_mask_rand_all_opt = cat(3,median_mask_rand_all_opt,mask_rand_all_opt{i});
end

median_mask_rand_vertex_opt=median(median_mask_rand_vertex_opt,3);
median_mask_rand_all_opt=median(median_mask_rand_all_opt,3);

%riassegno risultati alle variabili per comodità
mask_rand_vertex_opt=median_mask_rand_vertex_opt;
mask_rand_all_opt=median_mask_rand_all_opt;

hold on ;
figure;
subplot(421);
imagesc(mask_standard_opt);title ('Maschera standard finale ');
show_defects(img,mask_standard_opt,kernel_size,422,'')
subplot(423);
imagesc(mask_rand_all_opt);title ('Maschera randomica generica finale ');
show_defects(img,mask_rand_all_opt,kernel_size,424,'')
subplot(425);
imagesc(mask_rand_vertex_opt);title ('Maschera randomica vertitici finale ');
show_defects(img,mask_rand_vertex_opt,kernel_size,426,'')
subplot(427);
imagesc(mask_crop_opt);title ('Maschera con kernel scelto manualmente ');
show_defects(img,mask_crop_opt,size(kernel_crop),428,'crop')
hold off;

%% TEST MARCO
% seleziono la maschera migliore tra quelle risultanti
final{1}=mask_standard_opt;
final{2}=mask_rand_all_opt;
final{3}=mask_rand_vertex_opt;
final{4}=imresize(mask_crop_opt,size(mask_rand_vertex_opt));

for i=1:numel(final)
    sum_final(i)=sum(final{i},'all');
end

%quanti pixel ha mediamente la maschera
mean_final=sum(sum_final,'all')/numel(final);

%elimino maschere sbagliate
final=cleanSomeMask(final,mean_final,numel(final));


median_final=final{1};
if(numel(final)>1)
for i=2:numel(final)
    median_final=cat(3,median_final,final{i});
end
end
median_final=median(median_final,3);

figure(4);
imagesc(median_final);title ('Maschera finale ');
show_defects(img,median_final,kernel_size,111,'')

