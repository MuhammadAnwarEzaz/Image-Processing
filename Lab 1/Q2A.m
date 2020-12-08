matA(1:256, 1:256) = uint8(255);
radius = 40;
for r = radius+1:0.01:radius+8
    for ang = 0:0.01:2*pi
        x = round(r*cos(ang)+127);
        y = round(r*sin(ang)+127);
        matA(x,y) = 1;
    end
end
imshow(matA);