clear
I = imread('3.jpg');
R = I(:,:,1);
%imshow(R);
%imwrite(R,'RLayer.jpg');
Rmin = min(R,[],'all');
Rmax = max(R,[],'all');
Rll = 0.0*(Rmax-Rmin);
Rhl = 0.33*(Rmax-Rmin);
R(R>=Rll & R<=Rhl) = 2*R(R>=Rll & R<=Rhl);
imshow(R);
imwrite(R,'Output_3A.jpg');