clear
I = imread('1.jpg');
I = 255 - I;
[R C] = size(I);
t = 3*pi/4;

[Y,X] = meshgrid(1:C, 1:R);

X2 = X.*cos(t)-Y.*sin(t);
Y2 = X.*sin(t)+Y.*cos(t);

x = round(X2);
y = round(Y2);

if (min(x(:))<0)
    nx = max(x(:))+abs(min(x(:)))+1;
    x = x + abs(min(x(:)))+1;
else
    nx = max(x(:));
end

if (min(y(:))<0)
    ny = max(y(:))+abs(min(y(:)))+1;
    y = y + abs(min(y(:)))+1;
else
    ny = max(y(:));
end

I1 = uint8(zeros([nx ny]));

for i = 1:R
    for j = 1:C
        I1(x(i,j),y(i,j)) = I(i,j);
    end
end

I2 = I1;
for k = 1:2
    I2 = I1;
    for i = 2:size(I1,1)-1
        for j = 2:size(I1,2)-1
            T = I1(i-1:i+1,j-1:j+1);
            if (T(5)==0 && sum(T(:))~=0)
                idx = find(T~=0);
                [~,idx] = sort(abs(idx-5));
                I2(i,j) = T(find(idx==1));
            end
        end
    end
    I1 = I2;
end
imshow(I2);
imwrite(I2,'Output_1B.jpg');


