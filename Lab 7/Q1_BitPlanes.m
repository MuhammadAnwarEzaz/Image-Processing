clear
I = imread('face_image.jpg');
subplot(2,5,1);
imshow(I);
title('Original Image');

I = rgb2gray(I);
subplot(2,5,2);
imshow(I);
title('Original Grayscale Image');

[R C] = size(I);
for k = 1:8
    BIT_PLANE(:,:,k) = mod(I,power(2,k))>= power(2,k-1);
end

for i = 1:8
    subplot(2,5,i+2);
    imshow(BIT_PLANE(:,:,i));
    title('Bit Plane '+string(i));
end