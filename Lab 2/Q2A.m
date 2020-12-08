Lena = imread('Lena.png');
LenaBW = rgb2gray(Lena);
V = [1:86];
[R C] = size(LenaBW);
Bin_Matrix(1:R, 1:C) = false;
for i = 1:R
    for j = 1:C
        if ismember(LenaBW(i,j),V)
            Bin_Matrix(i,j) = true;
        end
    end
end

Label_Image = bwlabel(Bin_Matrix, 4); %4-connectivity

if Label_Image(LenaBW(37,6)) == Label_Image(LenaBW(33,10)) %4-path exists
    subplot(3,1,1);
    imshow(Lena);
    title('Original');
    subplot(3,1,2);
    imshow(LenaBW);
    title('GreyScale'); 
    subplot(3,1,3);
    imshow(Label_Image);
    title('Labled image'); 
    title("4-connected");
else
    disp("No 4-path between given pixels");
end