clear
I = imread('3.jpg');
G = I(:,:,2);
%imshow(G);
%imwrite(G,'GLayer.jpg');
Gmin = min(G,[],'all');
Gmax = max(G,[],'all');
Gll = 0.34*(Gmax-Gmin);
Ghl = 0.66*(Gmax-Gmin);
G(G>=Gll & G<=Ghl) = 2*G(G>=Gll & G<=Ghl);
imshow(G);
imwrite(G,'Output_3B.jpg');