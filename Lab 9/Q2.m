clear
I = imread('B.jpg');
I = rgb2gray(I);
[R C] = size(I);
F = [2,4,5,4,2;4,9,12,9,4;5,12,15,12,5;4,9,12,9,4;2,4,5,4,2]/159;
II = zeros(R+4,C+4);
II(3:R+2,3:C+2) = I;
for i = 3:R+2
    for j = 3:C+2
        IM(i-2,j-2) = sum(II(i-2:i+2,j-2:j+2).*F,'all');
    end
end
figure, imshow(IM,[]); title('Smoothened Image');
imwrite(uint8(IM),'Output_Q2_SmoothenedImage.jpg');
Sx = [-1 0 1;-2 0 2;-1 0 1];
Sy = [-1 -2 -1;0 0 0;1 2 1];

II = zeros(R+2,C+2);
II(2:R+1,2:C+1) = IM;
for i = 2:R+1
    for j = 2:C+1
        Gx(i-1,j-1) = sum(II(i-1:i+1,j-1:j+1).*Sx,'all');
        Gy(i-1,j-1) = sum(II(i-1:i+1,j-1:j+1).*Sy,'all');
    end
end

G = sqrt(Gx.^2 + Gy.^2);
theta = atan2d(Gy,Gx);
figure, imshow(G,[]); title('Gradient Image');
imwrite(uint8(G),'Output_Q2_GradientImage.jpg');

theta(theta<0) = theta(theta<0)+360;
theta((theta>=0 & theta<22.5)|(theta>=337.5 & theta<=360)|(theta >= 157.5 & theta < 202.5)) = 0;
theta((theta>=22.5 & theta<67.5)|(theta>=202.5 & theta<247.5)) = 45;
theta((theta>=67.5 & theta<112.5)|(theta>=247.5 & theta<292.5)) = 90;
theta((theta>=112.5 & theta<157.5)|(theta>=292.5 & theta<337.5)) = 135;

II = zeros(R+2,C+2);
II(2:R+1,2:C+1) = G;
for i = 2:R+1
    for j = 2:C+1
        if (theta(i-1,j-1) == 0)
            IX(i-1,j-1) = II(i,j) == max([II(i,j-1),II(i,j),II(i,j+1)]);
        elseif (theta(i-1,j-1) == 45)
            IX(i-1,j-1) = II(i,j) == max([II(i-1,j+1),II(i,j),II(i+1,j-1)]);
        elseif (theta(i-1,j-1) == 90)
            IX(i-1,j-1) = II(i,j) == max([II(i-1,j),II(i,j),II(i+1,j)]);
        elseif (theta(i-1,j-1) == 135)
            IX(i-1,j-1) = II(i,j) == max([II(i-1,j-1),II(i,j),II(i+1,j+1)]);
        end
    end
end
IX = IX.*G;
IX(1,:) = 0; IX(R,:) = 0; IX(:,1) = 0; IX(:,C) = 0;
figure, imshow(IX,[]); title('Result of Non-max suppression');
imwrite(uint8(IX),'Output_Q2_NonMaxSuppressedImage.jpg');


TH = 0.175*max(IX,[],'all');
TL = 0.075*max(IX,[],'all');

IH = IX>=TH;
IL = (IX>=TL)&(IX<TH);

figure, imshow(IL,[]); title('Weak Edges'); imwrite(mat2gray(IL),'Output_Q2_WeakEdges.jpg');
figure, imshow(IH,[]); title('Strong Edges'); imwrite(mat2gray(IH),'Output_Q2_StrongEdges.jpg');

for i = 1:R
    for j = 1:C
        if (IX(i,j) < TL)
            I_OUT(i,j) = false;
        elseif (IX(i,j) > TH)
            I_OUT(i,j) = true;
        elseif (IX(i-1,j-1) > TH || IX(i-1,j) > TH || IX(i-1,j+1) > TH || IX(i,j+1) > TH || IX(i+1,j+1) > TH || IX(i+1,j) > TH || IX(i+1,j-1) > TH || IX(i,j-1) > TH)
            I_OUT(i,j) = true;
        end
    end
end

figure, imshow(I_OUT); title('Canny Edge Detection'); imwrite(I_OUT,'Output_Q2_CannyEdgeDetectedImage.jpg');