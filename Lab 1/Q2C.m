matC(1:256, 1:256) = uint8(255);
radius = 40;

for r = radius+1:0.01:radius+8;
    for ang = 0:0.01:2*pi
        rin = r-28;
        x = round(rin*cos(ang)+127);
        y = round(rin*sin(ang)+127);
        matC(x,y) = 1;
        x = round(r*cos(ang)+127);
        y = round(r*sin(ang)+127);
        matC(x,y) = 1;
    end
end

for i = 1:size(matC,1)/2
    for j = 1:size(matC,2)/2
        ansC(i,j) = matC(i+64,j+64);
        ansC(i+128,j+128) = ansC(i,j);
        ansC(i,j+128) = ansC(i,j);
        ansC(i+128,j) = ansC(i,j);
    end
end

imshow(ansC);