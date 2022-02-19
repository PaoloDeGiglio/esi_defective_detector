function show_defects(img,mask,kernel_size,subplotplace,type,string)
A=img;
if(not(strcmp(type,'crop')))
    A = A(ceil(kernel_size/2):end-floor(kernel_size/2),ceil(kernel_size/2):end-floor(kernel_size/2));
else
    R=kernel_size(1,1);
    C=kernel_size(1,2);
    A = A(ceil(R/2):end-floor(R/2),ceil(C/2):end-floor(C/2));
end
A1 = A;
if((sum(mask,'all')>0))
    A1(mask)=255;
end

% Visualizzo a lato immagine A e immagine con il difetto evidenziato in rosso
Af = cat(3,A1,A,A);
subplot(subplotplace)
imshowpair(A,Af,'montage')
title (string);

end

