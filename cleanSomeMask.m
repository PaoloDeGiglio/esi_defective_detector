
function [newMask] = cleanSomeMask(mask,mean,number_of_mask,opt)

if(opt==1)
j=1;    %indice per nuova maschera
for i=1:number_of_mask
    s=sum(mask{i},'all');
    if(s>mean/2 && s<mean*2)  %le maschere valide devono stare tra la met� e il valore doppio
        newMask{j}=mask{i};
        j=j+1;
    end       
end
else
    newMask=zeros(size(mask{1}));
    % coordinate medie degli errori
    [x_global,y_global]=mean_coordinates(mask,number_of_mask);
    % coordinate accettabili
    x_global_min= x_global-(x_global*0.25);
    x_global_max= x_global+(x_global*0.25);
    y_global_min=y_global-(y_global*0.25);
    y_global_max=y_global+(y_global*0.25);
    
    %prendo la maschera che ha meno pixel rossi
    min= numel(mask{1});
    index=0;
    for i=1:number_of_mask
        if(min>sum(mask{i},'all'))
            min=sum(mask{i},'all');
            index=i;
        end
    end
    newMask=mask{index};
    
    for i=1:number_of_mask
        [x,y]=mean_coordinates(mask,number_of_mask);
        %controllo che le coordinate medie di quella maschera stiano
        %nell'intervallo
        valid= ((x>=x_global_min && x<=x_global_max) || (y>=y_global_min && y<=y_global_max));
        if(valid==true)
        if(mask{i}>mean)
            newMask=newMask==mask{i}; %prendo l'intersezione
        %else
            %newMask=newMask+mask{i};  %prendo l'unione
        end
        end
        mediana=cat(3,mask{1},mask{2},mask{3},mask{4});
        mediana=median(mediana,3);
        
        newMask=newMask+mediana;

    end
    newMask=newMask~=0;
end
end