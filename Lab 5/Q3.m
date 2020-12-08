clear
I = imread('image.jpg');
I = rgb2gray(I);
I = imresize(I,[256 256]);
m = min(I,[],'all');
M = max(I,[],'all');
In = (double(I-m))*(double((255/double(M-m))));
In = uint8(In);

for i = 2:255
    for j = 2:255
        x = In(i,j);
        %l = [In(i-1,j-1)>=x,In(i+1,j+1)>=x,In(i-1,j)>=x,In(i+1,j)>=x,In(i-1,j+1)>=x,In(i+1,j-1)>=x,In(i,j+1)>=x,In(i,j-1)>=x];
        l = [In(i-1,j-1)>=x,In(i-1,j)>=x,In(i-1,j+1)>=x,In(i,j+1)>=x,In(i+1,j+1)>=x,In(i+1,j)>=x,In(i+1,j-1)>=x,In(i,j-1)>=x];
        str = num2str(l);
        str(isspace(str)) = '';
        y = bin2dec(str);
        Ix(i-1,j-1) = uint8(y);
    end
end

freq = zeros(1,256)

for k = 1:256
    fre(k) = sum(Ix(:) == k-1)
end
n = 0:255
stem(n,fre);
title('Image Histogram');