function [size] = kernel_size(img)

% references: "https://it.mathworks.com/help/images/derive-statistics-from-glcm-and-plot-correlation.html"
% Funzione che attraverso la gray-level co-occurrence matrix individua 
% il pattern naturale del tessuto determinando così la dimensione ideale
% del kernel
% Essendo il calolo di questa matrice molto costoso imponiamo una soglia
% superiore

%img = rgb2gray(imread("images\img-16.jpg"));
max_kernel_size = 40;
offset0 = [zeros(max_kernel_size,1) (1:max_kernel_size)'];
glcms = graycomatrix(img, 'Offset', offset0);
stats = graycoprops(glcms, 'Correlation');

% I picchi rappresentano i punti di massima correlazione => ogni valore di
% offset ha il suo livello di correlazione; prendiamo il più alto
%figure, plot([stats.Correlation]);
%title('Texture Correlation as a function of offset');
%xlabel('Horizontal Offset')
%ylabel('Correlation')

[val,~] = findpeaks(stats.Correlation);
size = round(length(val)/2);


