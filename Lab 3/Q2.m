clear
I = imread('2.jpg');
for i = 1:size(I,3)
    L = I(:,:,i);
    minm = min(L,[],'all');
    maxm = max(L,[],'all');
    n_min = minm + 0.15*(maxm - minm);
    n_max = minm + 0.7*(maxm - minm);
    slope = (double(n_max-n_min))/(double(maxm-minm));
    c = n_max-slope*maxm;
    I_OUT(:,:,i) = slope*L + c;
end
imshow(I_OUT);
imwrite(I_OUT,'Output_2.jpg');