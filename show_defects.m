function show_defects(img,mask,kernel_size,subplotplace,type)
A=img;
if(not(strcmp(type,'crop')))
    A = A(ceil(kernel_size/2):end-floor(kernel_size/2),ceil(kernel_size/2):end-floor(kernel_size/2)); %499x499
else
    R=kernel_size(1,1);
    C=kernel_size(1,2);
    A = A(ceil(R/2):end-floor(R/2),ceil(C/2):end-floor(C/2));
end
A1 = A;
A1(mask)=255;

% Visualizzo a lato immagine A e immagine con il difetto evidenziato in rosso
Af = cat(3,A1,A,A);
subplot(subplotplace)
imshowpair(A,Af,'montage')
title ('Immagine e Difetto finale')

end

