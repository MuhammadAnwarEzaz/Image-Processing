clear
I = imread('face_image.jpg');
I = rgb2gray(I);
[R C] = size(I);
for k = 1:8
    BIT_PLANE(:,:,k) = mod(I,power(2,k))>= power(2,k-1);
end

B = true(3,3);
plt = 1;
for k = [1,3,7]
    II = BIT_PLANE(:,:,k);
    IM = false(R,C);
    for i = 2:R-1
        for j = 2:C-1
            IM_I = II(i-1:i+1,j-1:j+1);
            IX = IM_I(B);
            IM(i,j) = max(IX,[],'all');
        end
    end
    subplot(2,3,plt);
    imshow(IM);
    title('Dialation of Bitplane '+string(k));
    plt = plt+1;
end

for k = [1,3,7]
    II = BIT_PLANE(:,:,k);
    IM = false(R,C);
    for i = 2:R-1
        for j = 2:C-1
            IM_I = II(i-1:i+1,j-1:j+1);
            IX = IM_I(B);
            IM(i,j) = min(IX,[],'all');
        end
    end
    subplot(2,3,plt);
    imshow(IM);
    title('Erosion of Bitplane '+string(k));
    plt = plt+1;
end