function [newMask] = cleanSomeMask(mask,mean,number_of_mask)

j=1;    %indice per nuova maschera
for i=1:number_of_mask
    s=sum(mask{i},'all');
    if(s>mean/2 && s<mean*2)  %le maschere valide devono stare tra la metà e il valore doppio
        newMask{j}=mask{i}
        j=j+1;
    end       
end

if(j==1) %l'approccio non ha trovato maschere, restituisco come risulato l'unione di quelli che hanno puntini
    newMask=mask{1};
    for i=2:number_of_mask
        newMask=newMask+mask{i};
    end
    newMask=newMask~=0;
end
    
end