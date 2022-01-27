function [new_mask] = mask_optimization(mask)
mask = cMedia<prctile(cMedia,10,'all');
se = strel('disk',2,0);
new_mask = imopen(mask,se);
end

