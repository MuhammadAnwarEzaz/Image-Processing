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

table(:,1) = [0:255];
table(:,2) = fre;
s = sum(fre,'all')
table(:,3) = table(:,2)/s

for i = 1:256
    if i == 1
        table(i,4) = table(i,3);
    else
        table(i,4) = table(i-1,4)+table(i,3);
    end
end

table(:,5) = 255*table(:,4);
table(:,6) = round(table(:,5));

for i = 1:size(Ix,1)
    for j = 1:size(Ix,2)
        Eq_I(i,j) = table(Ix(i,j)+1,6);
    end
end

%map = unique(table(:,6));
map = zeros(1,256);
for i = 1:256
    map(table(i,6)+1)=map(table(i,6)+1)+table(i,2);
end

n = 0:255;
subplot(2,2,1);
imshow(Ix);
title('Image after Binary to decimal Conversion');
subplot(2,2,2);
stem(n,fre);
title('Image Histogram');
subplot(2,2,4);
imshow(uint8(Eq_I));
title('Equalised Image');
subplot(2,2,3);
stem(n,map);
title('Equalised Histogram');