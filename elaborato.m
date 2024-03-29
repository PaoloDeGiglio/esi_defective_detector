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
imagesc(img); axis image; colormap gray; title("IMMAGINE DI PARTENZA - Seleziona il kernel");hold on;

%% SELEZIONE DIMENSIONE PATTERN

kernel_size = kernel_size(img);
num_kernels = 12;
kernel_size = 12;
number_iteration=10;
%% SELEZIONE PATTERN SECONDO I VARI APPROCCI

kernel_standard = create_kernel(img,'standard','all',kernel_size,num_kernels);
for i=1:number_iteration
kernel_rand_all{i} = create_kernel(img,'random','all',kernel_size,num_kernels);
kernel_rand_vertex{i} = create_kernel(img,'random','vertex',kernel_size,num_kernels);
end
kernel_crop=imcrop(img);    %selezione manuale kernel
%metto le dimensioni secondo standard
kernel_crop=kernel_crop(1:kernel_size,1:kernel_size);

%% CROSSCORRELAZIONE MASCHERE

c_mask_standard= create_mask(img,kernel_standard, num_kernels, kernel_size,'');
for i=1:number_iteration
 c_mask_rand_all{i} = create_mask(img,kernel_rand_all{i}, num_kernels, kernel_size,'');
 c_mask_rand_vertex{i} = create_mask(img,kernel_rand_vertex{i}, num_kernels, kernel_size,'');
end
c_mask_crop=create_mask(img,kernel_crop, 1, kernel_size,'crop');

%% EROSIONE MORFOLOGICA E PERCENTILE MASCHERE

mask_standard_opt = mask_optimization(c_mask_standard);
% per robustezza genero pi� maschere random
for i=1:number_iteration
mask_rand_all_opt{i} = mask_optimization(c_mask_rand_all{i});
mask_rand_vertex_opt{i} = mask_optimization(c_mask_rand_vertex{i});
end
mask_crop_opt=mask_optimization(c_mask_crop);

%% Tolgo maschere errate

mask_rand_vertex_opt=deleteWrongMask(mask_rand_vertex_opt,number_iteration);
mask_rand_all_opt=deleteWrongMask(mask_rand_all_opt,number_iteration);

%% Calcolo la mediana delle maschere randomiche

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

%riassegno risultati alle variabili per comodit�
mask_rand_vertex_opt=median_mask_rand_vertex_opt;
mask_rand_all_opt=median_mask_rand_all_opt;

%% Visualizzo figure
hold on ;
figure;
subplot(421);
imagesc(mask_standard_opt);title ('Maschera standard finale ');
show_defects(img,mask_standard_opt,kernel_size,422,'','Standard')
subplot(423);
imagesc(mask_rand_all_opt);title ('Maschera randomica generica finale ');
show_defects(img,mask_rand_all_opt,kernel_size,424,'','Random all')
subplot(425);
imagesc(mask_rand_vertex_opt);title ('Maschera randomica vertitici finale ');
show_defects(img,mask_rand_vertex_opt,kernel_size,426,'','Random vertex')
subplot(427);
imagesc(mask_crop_opt);title ('Maschera con kernel scelto manualmente ');
show_defects(img,mask_crop_opt,size(kernel_crop),428,'crop','Crop')
hold off;

%% Seleziono la maschera migliore tra quelle risultanti
final{1}=mask_standard_opt;
final{2}=mask_rand_all_opt;
final{3}=mask_rand_vertex_opt;
final{4}=mask_crop_opt;

%ottengo maschera migliore e migliore pulita
[final, finalCleaned]=obtainBestMask(final,4);

% visualizzo
hold on;
figure;
show_defects(img,final,kernel_size,121,'','Finale');
show_defects(img,finalCleaned,kernel_size,122,'','Finale pulita');
hold off;
