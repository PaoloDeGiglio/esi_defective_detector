% pulisce la maschera tramite disco
function [new_mask] = mask_optimization(crossCorrelationMean)
mask = crossCorrelationMean<median(crossCorrelationMean,'all');
se = strel('disk',2,0);
new_mask = imopen(mask,se);
end

