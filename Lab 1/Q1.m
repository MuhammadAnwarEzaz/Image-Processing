img = imread('cameraman.tif');
img = imresize(img, [64,64]);
for i = 1:size(img,1)
    for j=1:size(img,2)
        m = min(img,[],'all');
        [x,y]= find(img == m,1, 'last');
        new_mat(j,i) = m;
        img(x,y) = 255;
    end
end
imshow(new_mat);