clear
I = imread('morphology.tif');
[R C] = size(I);
B = true(3,3);
%Padding
II = false(R+2,C+2);
for i = 2:R+1
    for j = 2:C+1
        II(i,j) = I(i-1,j-1);
    end
end

IE = false(R+2,C+2);
for i = 2:R+1
    for j = 2:C+1
        IE_I = II(i-1:i+1,j-1:j+1);
        IX = IE_I(B);
        IE(i,j) = min(IX,[],'all');
    end
end

ID = false(R+2,C+2);
for i = 2:R+1
    for j = 2:C+1
        ID_I = IE(i-1:i+1,j-1:j+1);
        IX = ID_I(B);
        ID(i,j) = max(IX,[],'all');
    end
end

%Remove Padding
for i = 2:R+1
    for j = 2:C+1
        I_OPENED(i-1,j-1) = ID(i,j);
    end
end
imwrite(I_OPENED,'Q1_Opening.jpg');
subplot(1,2,1);
imshow(I_OPENED);
title('Image After Opening');

ID = false(R+2,C+2);
for i = 2:R+1
    for j = 2:C+1
        ID_I = II(i-1:i+1,j-1:j+1);
        IX = ID_I(B);
        ID(i,j) = max(IX,[],'all');
    end
end

IE = false(R+2,C+2);
for i = 2:R+1
    for j = 2:C+1
        IE_I = ID(i-1:i+1,j-1:j+1);
        IX = IE_I(B);
        IE(i,j) = min(IX,[],'all');
    end
end

%Remove Padding
for i = 2:R+1
    for j = 2:C+1
        I_CLOSED(i-1,j-1) = IE(i,j);
    end
end
imwrite(I_CLOSED,'Q1_Closing.jpg');
subplot(1,2,2);
imshow(I_CLOSED);
title('Image After Closing');