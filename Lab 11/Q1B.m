clear
img = imread('FigP0936.tif');
I = (img >= 128); %Convert to Binary image
[R C] = size(I);
IPAD = true(R+2,C+2);
IPAD(2:R+1,2:C+1) = I;
B = true(3,3);
X = false(R+2,C+2);
X(1,1) = true;
%Connected components algorithm
while true
    IX = imdilate(X,B); %Used predefined function for dilation because own implementation is too slow, Have used own implementation in Q1A
    Xk = (IX & IPAD);
    if Xk == X
        break;
    else
        X = Xk;
    end
end
I_BORDER = Xk(2:R+1,2:C+1);
%Remove the circles merging to border
II = (I & ~I_BORDER);
Area = 225;
IVIS = false(R,C);
I_OVERLAP = false(R,C);
for i = 1:R
    for j = 1:C
        if IVIS(i,j) == true || II(i,j) == false
            continue;
        end
        X = false(R,C);
        X(i,j) = true;
        %Connected components algorithm
        while true
            IX = imdilate(X,B); %Used predefined function for dilation because own implementation is too slow, Have used own implementation in Q1A
            Xk = (IX & II);
            if Xk == X
                break;
            else
                X = Xk;
            end
        end
        IVIS = (IVIS | Xk);
        if sum(Xk,'all') > Area+10 %For accomodating small variations in size of circles due to noise
            I_OVERLAP = (I_OVERLAP | Xk);
        end
    end
end
imshow(I_OVERLAP);
title('Overlapping Particles');
imwrite(I_OVERLAP,'Output_Q1B.jpg');