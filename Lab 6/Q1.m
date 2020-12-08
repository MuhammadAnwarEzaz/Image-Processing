clear
I = imread('A.jpg');
B = [2,1,9;7,18,6;0,1,87];
s = sum(B,'all');
[R C D] = size(I);
for p = 1:D
    IMOD = zeros(R+2,C+2);
    for i = 2:R+1
        for j = 2:C+1
            IMOD(i,j) = double(I(i-1,j-1,p));
        end
    end
    %IMOD IS IMAGE PADDED WITH ZEROS
    
    II = zeros(R+2,C+2);
    for i = 2:R+1
        for j= 2:C+1
            x = 1;
            summ = 0;
            for a = -1:1
                y = 1;
                for b = -1:1
                    summ = summ + B(x,y)*IMOD(i+a,j+b);
                    y = y+1;
                end
                x = x+1;
            end
            II(i,j) = summ;
        end
    end
    %II is filtered image padded with zeros
    
    for i = 2:R+1
        for j = 2:C+1
            IP(i-1,j-1) = II(i,j);
        end
    end
    %IP is filterd iamge after removal of padding
    
    I_FILTERED(:,:,p) = mat2gray(IP);
end

%I_FILTERED is filtered RGB image
imshow(uint8(I_FILTERED));
title('Filtered Image');