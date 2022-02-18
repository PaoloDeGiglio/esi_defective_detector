%calcolo x,y medio degli errori
function [x_mean y_mean] = mean_coordinates(mask, number_of_mask)
cumulative_r=0;
cumulative_c=0;
for i=1:number_of_mask
   [r,c]=find(mask{i}==1);
    cumulative_r=[cumulative_r;r];
    cumulative_c=[cumulative_c;c]; 
end
x_mean=sum(cumulative_r,'all')/numel(cumulative_r);
y_mean=sum(cumulative_c,'all')/numel(cumulative_c);
end