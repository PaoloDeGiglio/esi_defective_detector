%return a array of a struct that contains kernel information, 
% param: IMG (immagine), mode (standard or random), position (vertex or
% all), kernel_dim (dimension)
%alt: create_kernel(IMG,'random','vertex',12)
% create_kernel(IMG,'standard','-',12)
% create_kernel(IMG,'random','all',12)
function [kernel] = create_kernel(IMG,mode,position,kernel_dim)
    %fisso il numero di kernel
    num_kernels=12;
    %calcolo dimensioni immagine 
    [IMG_x, IMG_y]=size(IMG);
   
    % mode standard su tutta l'immagine (metto 12 quadratini a vertici)
    if(strcmp(mode,'standard'))
        for i=1:(num_kernels)
            if(i<=3) %alto a sx
             kernel{i}.img=IMG(i:kernel_dim+i,i:kernel_dim+i)
             kernel{i}.basex=i;
             kernel{i}.basey=i;
            end
            if(i>3 && i<=6) %alto a dx
             kernel{i}.img = IMG(IMG_x-kernel_dim-i:IMG_x,i:kernel_dim+i);
             kernel{i}.basex=IMG_x-kernel_dim-i;
             kernel{i}.basey=i;
            end
            if(i>6 && i<=9) %basso dx
              kernel{i}.img = IMG(IMG_x-kernel_dim-i:IMG_x,IMG_y-kernel_dim-i:IMG_y);
              kernel{i}.basex=IMG_x-kernel_dim-i;
              kernel{i}.basey=IMG_y-kernel_dim-i;
            end
            if(i>9 && i<=12)   %basso sx
             kernel{i}.img = IMG(i:kernel_dim,IMG_y-kernel_dim-i:IMG_y);
             kernel{i}.basex=i;
             kernel{i}.basey=IMG_y-kernel_dim-i;
             
            end
             kernel{i}.dim=kernel_dim;
                
        end
    end
    
    % mode random su tutta l'immagine
    if(strcmp(mode,'random') && strcmp(position,'all'))
        for k = 1:(num_kernels)
           x=randi(IMG_x - kernel_dim,1);
           y=randi(IMG_y - kernel_dim,1);
           kernel{k}.img=IMG(x:x+kernel_dim-1, y:y+kernel_dim-1);
           kernel{k}.basex=x;
           kernel{k}.basey=y;
           kernel{k}.dim=kernel_dim;
        end
    end
    
    % mode random ai vertici
    if(strcmp(mode,'random') && strcmp(position,'vertex'))
        p=15;    %specifica quanto è grande il vertice rispetto all'immagine
        %lunghezze dove andrò a prendere kernel
        l_x=round((IMG_x/100)*p);
        l_y=round((IMG_y/100)*p);
        
        k1=IMG(1:l_x,1:l_y);
        k2=IMG(IMG_x+1-l_x:IMG_x,1:l_y);
        k3=IMG(1:l_x,IMG_y+1-l_y:IMG_y);
        k4=IMG(IMG_x+1-l_x:IMG_x,IMG_y+1-l_y:IMG_y);
        
        [k_x k_y]=size(k1); %tanto sono tutti uguali
        %prendo nel primo, poi secondo, poi terzo, poi quarto quadrante
        for k = 1:(num_kernels)
          
           x=randi(k_x - kernel_dim,1);
           y=randi(k_y - kernel_dim,1);
           %primo quadrante
           if(k<=3)
             kernel{k}.img=k1(x:x+kernel_dim-1, y:y+kernel_dim-1);
             kernel{k}.basex=x;
             kernel{k}.basey=y;
             kernel{k}.dim=kernel_dim;
           end
           
           x=randi(k_x - kernel_dim,1);
           y=randi(k_y - kernel_dim,1);
           %secondo quadrante
           if(k>3 && k<=6)
             kernel{k}.img=k2(x:x+kernel_dim-1, y:y+kernel_dim-1);
             kernel{k}.basex=IMG_x-l_x+x;
             kernel{k}.basey=y;
             kernel{k}.dim=kernel_dim;
           end
           
           x=randi(k_x - kernel_dim,1);
           y=randi(k_y - kernel_dim,1);
           %terzo quadrante
           if(k>6 && k<=9)
             kernel{k}.img=k3(x:x+kernel_dim-1, y:y+kernel_dim-1);
             kernel{k}.basex=x;
             kernel{k}.basey=IMG_y-l_y+y;
             kernel{k}.dim=kernel_dim;
           end
           
           x=randi(k_x - kernel_dim,1);
           y=randi(k_y - kernel_dim,1);
           %quarto quadrante
           if(k> 9 && k<=12)
             kernel{k}.img=k4(x:x+kernel_dim-1, y:y+kernel_dim-1);
             kernel{k}.basex=IMG_x-l_x+x;
             kernel{k}.basey=IMG_y-l_y+y;
             kernel{k}.dim=kernel_dim;
           end
           
          
        end
    end
    
    %visualizzo i kernel 
    subplot(231); 
    imagesc(IMG); axis image; colormap gray; hold on;
    for j=1:num_kernels
        rectangle('position',[kernel{j}.basex,kernel{j}.basey,kernel{j}.dim,kernel{j}.dim],'EdgeColor','r');  
    end
    hold off;
    

end
