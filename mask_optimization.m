function [new_mask] = mask_optimization(mask, crossCorrelationMean)
mask = crossCorrelationMean<median(crossCorrelationMean,'all');
se = strel('disk',2,0);
new_mask = imopen(mask,se);
end

