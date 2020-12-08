clear
I = imread('C.jpg');
D = [5,25,0,6,9; 59,62,0,7,8; 24,36,0,7,8; 0,0,0,0,0; 8,7,0,36,24; 8,4,0,62,59; 9,6,0,25,5];
D = D/8;
s = sum(D,'all');
[R C] = size(I);

IMOD = zeros(R+6,C+4);
for i = 4:R+3
    for j = 3:C+2
        IMOD(i,j) = double(I(i-3,j-2));
    end
end
%IMOD IS IMAGE PADDED WITH ZEROS

II = zeros(R+6,C+4);
for i = 4:R+3
    for j = 3:C+2
        summ = 0;
        x = 1;
        for a = -3:3
            y = 1;
            for b = -2:2
                summ = summ + IMOD(i+a,j+b)*D(x,y);
                y = y+1;
            end
            x = x+1;
        end
        II(i,j) = summ/s;
    end
end
%II is filtered image padded with zeros

for i = 4:R+3
    for j = 3:C+2
        I_FILTERED(i-3,j-2) = II(i,j);
    end
end
%I_FILTERED is blurred image after removal of padding

%Steps of Highboost Filtering
k = [2,3,4,5,10];
I_MASK = double(I) - I_FILTERED;
subplot(2,3,1);
imshow(mat2gray(I_FILTERED));
title('Blurred Image');

for i = 1:size(k,2)
    I_HIGHBOOST = double(I) + k(i)*I_MASK;
    subplot(2,3,i+1);
    imshow(uint8(I_HIGHBOOST));
    title('Highboost Image for k = '+string(k(i)));
end
%Images shown for k = 0,1,2,5,10
%Images can be displayed for other values also