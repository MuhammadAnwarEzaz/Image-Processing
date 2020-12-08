clear
I = imread('C.jpeg');
I = rgb2gray(I);
subplot(1,4,1);
imshow(I);
title('Original Image');
ft = fft2(I);
subplot(1,4,2);
imshow(abs(ft),[]);
title('Fourier Transform Spectrum');
imwrite(mat2gray(abs(ft)),'Output_Q3_FourierSpectrum.jpg');
subplot(1,4,3);
imshow(abs(fftshift(ft)),[]);
title('Centered Spectrum');
imwrite(mat2gray(abs(fftshift(ft))),'Output_Q3_CentredFourierSpectrum.jpg');
subplot(1,4,4);
imshow(angle(ft),[]);
title('Fourier Transform Phase');
imwrite(mat2gray(angle(ft)),'Output_Q3_Angle.jpg');