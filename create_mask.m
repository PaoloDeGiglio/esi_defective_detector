function [crossCorrelationMean] = create_mask(img,pattern,num_patterns, kernel_size)
[M,N] = size(img);
R=kernel_size;
C=kernel_size;
% Calcolo per ogni pattern la cross-correlazione 2D (normalizzata). Attenzione all'ordine delle variabili in input!
% L'output avra' dimensione (M+R-1,N+C-1)
sumC=zeros((M+R-1),(N+C-1));
for i=1:num_patterns
    fprintf("COrr %i %i\n", size(normxcorr2(pattern{i}.img,img)));
    fprintf("Sum C %i %i" + ...
        "\n", size(sumC));
    b= normxcorr2(pattern{i}.img,img);  %sommo tutte le correlazioni
    sumC=sumC+b;
end

% Calcolo la cross-correlazione media, che avra' sempre dimensione (M+R-1,N+C-1)
crossCorrelationMean=sumC/num_patterns;

crossCorrelationMean = crossCorrelationMean(R:end-R+1,C:end-C+1);

crossCorrelationMean=abs(crossCorrelationMean);

end

