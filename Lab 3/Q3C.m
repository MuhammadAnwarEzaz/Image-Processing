clear
I = imread('3.jpg');
B = I(:,:,3);
%imshow(B);
%imwrite(B,'BLayer.jpg');
Bmin = min(B,[],'all');
Bmax = max(B,[],'all');
Bll = 0.67*(Bmax-Bmin);
Bhl = 1*(Bmax-Bmin);
B(B>=Bll & B<=Bhl) = 2*B(B>=Bll & B<=Bhl);
imshow(B);
imwrite(B,'Output_3C.jpg');