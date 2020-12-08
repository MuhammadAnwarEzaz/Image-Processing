clear
I = imread('3.jpg');
R = I(:,:,1);

Rmin = min(R,[],'all');
Rmax = max(R,[],'all');
Rll = 0.0*(Rmax-Rmin);
Rhl = 0.33*(Rmax-Rmin);
R(R>=Rll & R<=Rhl) = 2*R(R>=Rll & R<=Rhl);

G = I(:,:,2);
Gmin = min(G,[],'all');
Gmax = max(G,[],'all');
Gll = 0.34*(Gmax-Gmin);
Ghl = 0.66*(Gmax-Gmin);
G(G>=Gll & G<=Ghl) = 2*G(G>=Gll & G<=Ghl);

B = I(:,:,3);
Bmin = min(B,[],'all');
Bmax = max(B,[],'all');
Bll = 0.67*(Bmax-Bmin);
Bhl = 1*(Bmax-Bmin);
B(B>=Bll & B<=Bhl) = 2*B(B>=Bll & B<=Bhl);

CombinedLayerImage(:,:,1) = R;
CombinedLayerImage(:,:,2) = G;
CombinedLayerImage(:,:,3) = B;
imshow(CombinedLayerImage);
imwrite(CombinedLayerImage,'Output_3.jpg');