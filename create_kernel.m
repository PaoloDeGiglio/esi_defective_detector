%return a array of a struct that contains kernel information, 
% param: IMG (immagine), mode (standard or random), position (vertex or
% all), kernel_dim (dimension)
%alt: create_kernel(IMG,'random','vertex',12)
% create_kernel(IMG,'standard','-',12)
% create_kernel(IMG,'random','all',12)
function [kernel] = create_kernel(IMG,mode,position,kernel_dim,num_kernels)
    %calcolo dimensioni immagine 
    [IMG_x, IMG_y]=size(IMG);
   
    % mode standard su tutta l'immagine (metto 12 quadratini a vertici)
    if(strcmp(mode,'standard'))
        
        for i=1:3
         kernel{i}.img=find_subMat(IMG,i,i,kernel_dim);
         kernel{i}.basex=i;
         kernel{i}.basey=i;
         kernel{i}.dim=kernel_dim;
        end
        
        for i=1:3
         kernel{3+i}.img=find_subMat(IMG,i,IMG_y-kernel_dim-i+1,kernel_dim);
         kernel{3+i}.basex=i;
         kernel{3+i}.basey=IMG_y-kernel_dim-i+1;
         kernel{3+i}.dim=kernel_dim;
        end
        
        for i=1:3
         kernel{6+i}.img=find_subMat(IMG,IMG_x-kernel_dim-i+1,i,kernel_dim);
         kernel{6+i}.basex=IMG_x-kernel_dim-i+1;
         kernel{6+i}.basey=i;
         kernel{6+i}.dim=kernel_dim;
        end
        
        for i=1:3
         kernel{9+i}.img=find_subMat(IMG,IMG_x-kernel_dim-i+1,IMG_y-kernel_dim-i+1,kernel_dim);
         kernel{9+i}.basex=IMG_x-kernel_dim-i+1;
         kernel{9+i}.basey=IMG_y-kernel_dim-i+1;
         kernel{9+i}.dim=kernel_dim;
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
end
