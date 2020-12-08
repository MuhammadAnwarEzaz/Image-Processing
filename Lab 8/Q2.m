clear
I = imread('img1.jpg');
I = rgb2gray(I);
I = I>=128;
[R C] = size(I);
B = true(3,3);
II = false(R+2,C+2);
for i = 2:R+1
    for j = 2:C+1
        II(i,j) = I(i-1,j-1);
    end
end

IE = false(R+2,C+2);
for i = 2:R+1
    for j = 2:C+1
        IE_I = II(i-1:i+1,j-1:j+1);
        IX = IE_I(B);
        IE(i,j) = min(IX,[],'all');
    end
end

for i = 2:R+1
    for j = 2:C+1
        I_ERODED(i-1,j-1) = IE(i,j);
    end
end

I_BOUNDARY = I&(~I_ERODED);
imwrite(I_BOUNDARY,'Q2_BoundaryExtraction.jpg');
imshow(I_BOUNDARY);
title('Boundary Extraction');