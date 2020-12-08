clear
I = imread('2.jpg');
I = rgb2gray(I);
subplot(3,1,1);
imshow(I);
title('Original Image');
[R,C]=size(I);
Z=zeros(1,256);
for i=1:R
    for j=1:C
        b=I(i,j);
        Z(b+1)=Z(b+1)+1;
    end
end

n=sum(Z);
p=zeros(1,256);
s=zeros(1,256);
c=zeros(1,256);
r=zeros(1,256);
for k=1:256
    p(k)=Z(k)/n;
    if k==1
        c(k)=p(k);
        s(k)=c(k)*255;
        r(k)=floor(s(k));
    else
        c(k)=c(k-1)+p(k);
        s(k)=c(k)*255;
        r(k)=floor(s(k));
    end
end
subplot(3,1,3);
stem(r,Z);
title('Histogram');