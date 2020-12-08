%Q1a
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
    for i = 3:R+2
        for j = 3:C+2
            I_FILTERED(i-2,j-2) = sum(II(i-2:i+2,j-2:j+2).*F,'all');
        end
    end
    subplot(1,3,k);
    imshow(I_FILTERED,[]);
    title('Gaussian Filtered Image, Sigma = '+string(sigma(k)));
end

%Q1b
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

%Q1c
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
    IX = abs(I_SHARP)-I_FILTERED(2:R+1,2:C+1);
    IOUT = double(I)+IX;
    subplot(1,3,k);
    imshow(IOUT,[]);
    title('Result of Adding to original image, Sigma = '+string(sigma(k)));
end

%Q2
clear
I = imread('larrypage2.jpg');
[R C D] = size(I);
for k = 1:3
    II = im2double(I(:,:,k));
    F = [0 0 1 0 0; 0 1 2 1 0; 1 2 -16 2 1; 0 1 2 1 0; 0 0 1 0 0];
    I_FILTERED = conv2(II,F);
    IZC = zeros(R,C);
    for i = 2:R-1
        for j = 2:C-1
            if (I_FILTERED(i,j)>0)
                if (I_FILTERED(i,j+1)>=0 && I_FILTERED(i,j-1)<0) || (I_FILTERED(i,j+1)<0 && I_FILTERED(i,j-1)>=0)             
                    IZC(i,j)= I_FILTERED(i,j+1);            
                elseif (I_FILTERED(i+1,j)>=0 && I_FILTERED(i-1,j)<0) || (I_FILTERED(i+1,j)<0 && I_FILTERED(i-1,j)>=0)
                    IZC(i,j)= I_FILTERED(i,j+1);
                elseif (I_FILTERED(i+1,j+1)>=0 && I_FILTERED(i-1,j-1)<0) || (I_FILTERED(i+1,j+1)<0 && I_FILTERED(i-1,j-1)>=0)
                    IZC(i,j)= I_FILTERED(i,j+1);
                elseif (I_FILTERED(i-1,j+1)>=0 && I_FILTERED(i+1,j-1)<0) || (I_FILTERED(i-1,j+1)<0 && I_FILTERED(i+1,j-1)>=0)
                    IZC(i,j)=I_FILTERED(i,j+1);
                end        
            end
        end
    end
    IOUT = im2uint8(IZC);
    IOUT = IOUT>100;
    subplot(1,3,k);
    imshow(IOUT);
    if k == 1
        title('LoG on R');
    elseif k == 2
        title('LoG on G');
    elseif k == 3
        title('LoG on B');
    end  
end