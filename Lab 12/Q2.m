clear
I = rgb2gray(imread('B.jpeg'));
[R C] = size(I);
n = [5,15,50,100];
plotnum = 1;
for k = n
    i = 1;
    j = 1;
    while true
        if j > C
            j = 1;
            i = i+1;
        end
        if i > R
            break;
        end
        if i == 1 & j < k %If the row is first and window size is less than n
            m = sum(I(i,1:j))/j;
        elseif j >= k & j <= C %If the window is completely in one row
            m = sum(I(i,j-k+1:j))/k;
        elseif j < k & i > 1 %If the some part of window is in previous row and some part in current row
            m = (sum(I(i,1:j))+sum(I(i-1,C-k+j+1:C)))/k;
        end
        IAV(i,j) = m;
        j = j+1;
    end
    I_OUT = I > IAV;
    %figure, imshow(IAV,[]);
    figure, imshow(I_OUT);
    title('Output for n = '+string(k));
    %imwrite(I_OUT,'Output_Q2_n_'+string(k)+'.jpg');
    plotnum = plotnum+1;
end