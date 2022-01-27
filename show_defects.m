function show_defects(img,mask,subplotplace)
A = img
A1 = img;
A1(maskfinal==1)=255;

% Visualizzo a lato immagine A e immagine con il difetto evidenziato in rosso
Af = cat(3,A1,A,A);
subplot(subplotplace)
imshowpair(A,Af,'montage')
title ('Immagine e Difetto finale')
end

