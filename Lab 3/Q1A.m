I = imread('1.jpg');
I_INV = 255 - I;
imshow(I_INV);
imwrite(I_INV,'Output_1A.jpg');