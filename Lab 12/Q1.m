clear
I = imread('A.jpg');
Sx = [1 0 -1;2 0 -2;1 0 -1];
Sy = [1 2 1;0 0 0;-1 -2 -1];
[R C] = size(I);
IPAD = zeros(R+2,C+2);
IPAD(2:R+1,2:C+1) = I;
for i = 2:R+1
    for j = 2:C+1
        Gx(i-1,j-1) = sum(IPAD(i-1:i+1,j-1:j+1).*Sx,'all');
        Gy(i-1,j-1) = sum(IPAD(i-1:i+1,j-1:j+1).*Sy,'all');
    end
end
G = sqrt(Gx.^2+Gy.^2);
A = atan2d(Gy,Gx);
T = 0.4*mean(I,'all');
for i = 1:R
    for j = 1:C
        I90(i,j) = (G(i,j) > T) & (((A(i,j) > 67.5) & (A(i,j) < 112.5))|((A(i,j) < -67.5) & (A(i,j) > -112.5)));
        I180(i,j) = (G(i,j) > T) & (((A(i,j) > 157.5) & (A(i,j) < 202.5))|((A(i,j) > -22.5) & (A(i,j) < 22.5)));
    end
end
for i = 1:R
    countx = 0;
    county = 0;
    for j = 1:C
        if I90(i,j) == false
            countx = countx + 1;
        elseif I90(i,j) == true
            if countx < 5
                I90(i,j-countx:j-1) = true;
            end
            countx = 0;
        end
        if I180(i,j) == false
            county = county + 1;
        elseif I180(i,j) == true
            if county < 5
                I180(i,j-county:j-1) = true;
            end
            county = 0;
        end
    end
end
figure, imshow(I90), title('Local processed image angle = 90'), imwrite(I90,'Output_Q1_angle90.jpg');
figure, imshow(I180), title('Local processed image angle = 180'), imwrite(I180,'Output_Q1_angle180.jpg');
figure, imshow(I90|I180), title('Local processed image, After preforming or operation'), imwrite(I180|I90,'Output_Q1_ORop.jpg');