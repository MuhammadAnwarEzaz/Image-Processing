clear
I = imread('UTK.tif');
I = I>=128;
[R C] = size(I);
B = imread('T.tif');
B = im2bw(B);
[r c] = size(B);

II = false(R,C);
for i = r/2+1:R-r/2-1
    for j = c/2+1:C-c/2-1
        IM = I(i-r/2:i+r/2-1,j-c/2:j+c/2-1);
        if IM == B
            II(i,j) = true;
        end
    end
end

imwrite(II,'Q3_HitAndMissTransform.jpg');
imshow(II);
title('Hit and Miss Transform');