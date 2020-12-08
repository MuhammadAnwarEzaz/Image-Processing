%Question 1C
I1 = imread('I1.jpg');

R = size(I1,1);
C = size(I1,2);
D = size(I1,3);
for i = 1:R
    for j = C:-1:1
        I2(i,C-j+1,:) = I1(i,j,:);
    end
end

for i = 1:2*R
    for j = 1:C
        if i <= R
            Vert_Cat(i,j,:) = I1(i,j,:);
        else
            Vert_Cat(i,j,:) = I2(i-R,j,:);
        end
    end
end

imshow(Vert_Cat);