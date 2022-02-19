%% Genero la maschera migliore e quella pulita
% La best sarà quella con la componente connessa più grande
% bestCleaned sarà uguale a best ma con delle componenti connesse molto
% piccole che sono state eliminate
function [best bestCleaned] = obtainBestMask(mask,number_of_mask)

maxAreaTot=0;  %area più grande
best=zeros(size(mask{1}));
   for i=1:number_of_mask
    [labeledMask, numberOfAreas] = bwlabel(mask{i}); %ottengo le componenti connesse e il numero
    aree = regionprops(labeledMask,'Area');    %ottengo le aree di ogni componente connessa della maschera
    
    %trovo la componente connessa più grande
    if(max([aree.Area])>maxAreaTot)
        best=mask{i};   %maschera migliore
        maxAreaTot=max([aree.Area]);
       
    
    %pulisco componenti connesse molto piccole
    for j=1:numberOfAreas
        if(aree(j).Area<(maxAreaTot/30))
            [r c]=find(labeledMask==j);
            labeledMask(r,c)=0; %tolgo componenti piccole
        end
    end
    bestCleaned=labeledMask~=0; %maschera migliore pulita
     
    
    end
    
   
   end
end