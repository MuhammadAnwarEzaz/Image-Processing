clear
I = imread('image.jpg');
I = rgb2gray(I);
I = imresize(I,[256 256]);
m = min(I,[],'all');
M = max(I,[],'all');
In = (double(I-m))*(double((255/double(M-m))));
In = uint8(In);
imshow(In);
title('Normalised Image');