clear
img = imread('FigP0936.tif');
I = (img >= 128); %Convert to Binary image
[R C] = size(I);
%Pad the image with white pixels
IPAD = true(R+2,C+2);
IPAD(2:R+1,2:C+1) = (I~=0);
%Structuring Element for Connected component algorithm
B = true(3,3);
X = false(R+2,C+2);
X(1,1) = true;
%Connected component algorithm
while true
    %Perform dialation
    IX = false(R+4,C+4);
    IX(2:R+3,2:C+3) = X;
    for i = 2:R+3
        for j = 2:C+3
            ID_I = IX(i-1:i+1, j-1:j+1);
            IA = ID_I(B);
            ID(i-1,j-1) = max(IA,[],'all');
        end
    end
    % Intersection
    Xk = (ID & IPAD);
    if Xk == X
        break;
    else
        X = Xk;
    end
end
%Remove the padding
I_BORDER = Xk(2:R+1,2:C+1);
imshow(I_BORDER);
title('Border Merging Particles');
imwrite(I_BORDER,'Output_Q1A.jpg');