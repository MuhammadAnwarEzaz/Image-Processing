clear
I = imread('larrypage2.jpg');
I = rgb2gray(I);
I = uint8(imresize(I,[128 128]));
[R C] = size(I);
sigma = [0.5 0.8 0.9];
for k = 1:size(sigma,2)
    F = fspecial('gaussian',[5 5],sigma(k));
    II = zeros(R+4,C+4);
    II(3:R+2,3:C+2) = double(I);
    I_FILTERED = zeros(R+2,C+2);
    for i = 3:R+2
        for j = 3:C+2
            I_FILTERED(i-1,j-1) = sum(II(i-2:i+2,j-2:j+2).*F,'all');
        end
    end
    L = [0 1 0;1 -4 1;0 1 0];
    for i = 2:R+1
        for j = 2:C+1
            I_SHARP(i-1,j-1) = sum(I_FILTERED(i-1:i+1,j-1:j+1).*L,'all');
        end
    end
    IOUT = I_SHARP-I_FILTERED(2:R+1,2:C+1);
    subplot(1,3,k);
    imshow(IOUT,[]);
    title('Result of Subtraction Sigma = '+string(sigma(k)));
end
