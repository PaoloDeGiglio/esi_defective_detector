function [value] = numBlobsMedian(mask,number_of_mask)
  res=0;
    for i=1:number_of_mask
       [~ , numBlobs] = bwlabel(mask{i});
       res=[res;numBlobs];
    end 
    value=median(res);
end