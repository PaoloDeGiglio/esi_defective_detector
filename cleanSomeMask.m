function [newMask] = cleanSomeMask(mask,mean,number_of_mask)

j=1;    %indice per nuova maschera
for i=1:number_of_mask
    s=sum(mask{i},'all');
    if(s>mean/2 && s<mean*2)  %le maschere valide devono stare tra la met� e il valore doppio
        newMask{j}=mask{i}
        j=j+1;
    end       
end
end