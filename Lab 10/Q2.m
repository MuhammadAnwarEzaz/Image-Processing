clear
I = imread('larrypage2.jpg');
[R C D] = size(I);
for k = 1:3
    II = im2double(I(:,:,k));
    F = [0 0 1 0 0; 0 1 2 1 0; 1 2 -16 2 1; 0 1 2 1 0; 0 0 1 0 0];
    I_FILTERED = conv2(II,F);
    IZC = zeros(R,C);
    for i = 2:R-1
        for j = 2:C-1
            if (I_FILTERED(i,j)>0)
             if (I_FILTERED(i,j+1)>=0 && I_FILTERED(i,j-1)<0) || (I_FILTERED(i,j+1)<0 && I_FILTERED(i,j-1)>=0)
                             
                IZC(i,j)= I_FILTERED(i,j+1);
                        
            elseif (I_FILTERED(i+1,j)>=0 && I_FILTERED(i-1,j)<0) || (I_FILTERED(i+1,j)<0 && I_FILTERED(i-1,j)>=0)
                    IZC(i,j)= I_FILTERED(i,j+1);
            elseif (I_FILTERED(i+1,j+1)>=0 && I_FILTERED(i-1,j-1)<0) || (I_FILTERED(i+1,j+1)<0 && I_FILTERED(i-1,j-1)>=0)
                  IZC(i,j)= I_FILTERED(i,j+1);
            elseif (I_FILTERED(i-1,j+1)>=0 && I_FILTERED(i+1,j-1)<0) || (I_FILTERED(i-1,j+1)<0 && I_FILTERED(i+1,j-1)>=0)
                  IZC(i,j)=I_FILTERED(i,j+1);
            end
                        
        end
        end
    end
    IOUT = im2uint8(IZC);
    %IOUT = IOUT>100;
    subplot(1,3,k);
    imshow(IOUT);
    if k == 1
        title('LoG on R');
    elseif k == 2
        title('LoG on G');
    elseif k == 3
        title('LoG on B');
    end  
end