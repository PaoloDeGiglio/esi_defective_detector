function [mask] = create_mask(img,pattern,num_patterns, kernel_size)
[M,N] = size(img);
R=kernel_size;
C=kernel_size;
% Calcolo per ogni pattern la cross-correlazione 2D (normalizzata). Attenzione all'ordine delle variabili in input!
% L'output avra' dimensione (M+R-1,N+C-1)
sumC=zeros(M+R-1,N+C-1);
for i=1:num_patterns
    fprintf("COrr %i %i\n", size(normxcorr2(pattern{i}.img,img)));
    fprintf("Sum C %i %i" + ...
        "\n", size(sumC));
    sumC=sumC+normxcorr2(pattern{i}.img,img);  %sommo tutte le correlazioni
end

% Calcolo la cross-correlazione media, che avra' sempre dimensione (M+R-1,N+C-1)
cMedia=sumC/num_patterns;

cMedia = cMedia(R:end-R+1,C:end-C+1);

mask=abs(cMedia);

end

