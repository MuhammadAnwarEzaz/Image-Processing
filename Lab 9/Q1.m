clear
I = imread('A.jpg');
P1 = [0,-1,-1;1,0,-1;1,1,0];
P2 = [1,1,0;1,0,-1;0,-1,-1];
S1 = [0,-1,-2;1,0,-1;2,1,0];
S2 = [2,1,0;1,0,-1;0,-1,-2];
[R C] = size(I);
IPAD = zeros(R+2,C+2);
IPAD(2:R+1,2:C+1) = I;
for i = 2:R+1
    for j = 2:C+1
        IP1(i-1,j-1) = sum(IPAD(i-1:i+1,j-1:j+1).*P1,'all');
        IP2(i-1,j-1) = sum(IPAD(i-1:i+1,j-1:j+1).*P2,'all');
        IS1(i-1,j-1) = sum(IPAD(i-1:i+1,j-1:j+1).*S1,'all');
        IS2(i-1,j-1) = sum(IPAD(i-1:i+1,j-1:j+1).*S2,'all');
    end
end
ISUB1 = abs(IS1) - abs(IP1);
ISUB2 = abs(IS2) - abs(IP2);

IP = sqrt(IP1.^2 + IP2.^2);
IS = sqrt(IS1.^2 + IS2.^2);
ISUB = (IS) - (IP);
 
figure, imshow(uint8(IP1)); title('Prewitt Filtered (Diagonal 1)');
figure, imshow(uint8(IP2)); title('Prewitt Filtered (Diagonal 2)');
figure, imshow(uint8(IP)); title('Prewitt Filtered (Combined)');
imwrite(uint8(IP),'Output_Q1_PrewittFilteredImage.jpg');
 
figure, imshow(uint8(IS1)); title('Sobel Filtered (Diagonal 1)');
figure, imshow(uint8(IS2)); title('Sobel Filtered (Diagonal 2)');
figure, imshow(uint8(IS)); title('Sobel Filtered (Combined)');
imwrite(uint8(IS),'Output_Q1_SobelFilteredImage.jpg');
 
figure, imshow(uint8(IP1)>=100); title('Edge Detection Prewitt Filter (Diagonal 1)');
figure, imshow(uint8(IP2)>=100); title('Edge Detection Prewitt Filter (Diagonal 2)');
figure, imshow(uint8(IP)>=100); title('Edge Detection Prewitt Filter (Combined)');
imwrite(uint8(IP)>=100,'Output_Q1_EdgeDetectedImagePrewittFilter.jpg');
 
figure, imshow(uint8(IS1)>=100); title('Edge Detection Sobel Filter (Diagonal 1)');
figure, imshow(uint8(IS2)>=100); title('Edge Detection Sobel Filter (Diagonal 2)');
figure, imshow(uint8(IS)>=100); title('Edge Detection Sobel Filter (Combined)');
imwrite(uint8(IS)>=100,'Output_Q1_EdgeDetectedImageSobelFilter.jpg');
 
figure, imshow(uint8(ISUB1)); title('After Subtraction (Diagonal 1)');
figure, imshow(uint8(ISUB2)); title('After Subtraction (Diagonal 2)');
figure, imshow(uint8(ISUB)); title('After Subtraction (Combined)');
imwrite(uint8(ISUB),'Output_Q1_SubtractionResult.jpg');