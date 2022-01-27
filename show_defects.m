function show_defects(img,mask,kernel_size,subplotplace)
A=img;
A = A(ceil(kernel_size/2):end-floor(kernel_size/2),ceil(kernel_size/2):end-floor(kernel_size/2)); %499x499

A1 = A;
A1(mask)=255;

% Visualizzo a lato immagine A e immagine con il difetto evidenziato in rosso
Af = cat(3,A1,A,A);
subplot(subplotplace)
imshowpair(A,Af,'montage')
title ('Immagine e Difetto finale')
end

