clear
I = imread('2.jpg');
I = rgb2gray(I);
alpha = [0.2,0.3,0.4,1,2,12];
A = 2;
for i = 1:size(alpha,2)
    I1 = A*(double(I).^alpha(i));
    M = max(I1,[],'all');
    m = min(I1,[],'all');
    subplot(2,3,i);
    imshow(I1,[]);
    title('alpha = '+string(alpha(i)));
end