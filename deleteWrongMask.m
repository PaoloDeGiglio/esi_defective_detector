%% Genera un insieme di maschere che non hanno troppe componenti connesse
function [maskCleaned] = deleteWrongMask(mask,number_of_mask)
    j=1;    %indice per il risultato
    maskCleaned{1}=zeros(size(mask{1}));
    num_blobs_median=numBlobsMedian(mask,number_of_mask);   %calcolo numero di componenti medie
    for i=1:number_of_mask
       [labeledImage, numBlobs] = bwlabel(mask{i});
       if(numBlobs<num_blobs_median)   %sono valide le maschere che hanno un numero di componenti connesse sotto la mediana
           maskCleaned{j}=mask{i};
           j=j+1;
       end
    end 
end