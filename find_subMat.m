function [subMat] = find_subMat(img, x, y, kernel_size)
    subMat=img(x:x+kernel_size-1,y:y+kernel_size-1);
end