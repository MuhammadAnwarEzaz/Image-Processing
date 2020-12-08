clear
I = imread('2.jpg');
I = rgb2gray(I);

for k = 5:7
    for i = 1:size(I,1)
        for j =1:size(I,2)
            if (mod(I(i,j),power(2,k+1))>=power(2,k))
                I1(i,j) = uint8(255);
            else
                I1(i,j) = uint8(0);
            end
        end
    end
    subplot(1,3,mod(k,4));
    imshow(I1);
    title(string(k+1)+'th bit-plane');
end
