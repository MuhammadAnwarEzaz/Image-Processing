%Question 1A
I1 = imread('I1.jpg');
[R C D] = size(I1);
for i = 1:R
    for j = C:-1:1
        I2(i,C-j+1,:) = I1(i,j,:);
    end
end
subplot(2,1,1);
imshow(I1);
title('Original Image');
subplot(2,1,2);
imshow(I2);
title('Mirror Image');