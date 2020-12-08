clear
I = imread('2.jpg');
I = rgb2gray(I);
mx = max(I,[],'all');

for i=1:size(I,1)
    for j=1:size(I,2)
        if (I(i,j)>=110 && I(i,j)<=200)
            I1(i,j) = mx - I(i,j);
        else
            I1(i,j) = I(i,j);
        end
    end
end
imshow(I1);