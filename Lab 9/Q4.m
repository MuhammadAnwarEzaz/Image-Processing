clear
I = imread('D.jpg');
[R C D] = size(I);
for i = 1:D
    II = I(:,:,i);
    ib1 = zeros(R,C); ib2 = zeros(R,C); iv1 = zeros(R,C); iv2 = zeros(R,C);
    T = 0.6*double(max(II,[],'all'));
    ib1(II >= T) = 1;
    ib2(II < T) = 1;
    iv1(II >= T) = 1;
    iv2(II < T) = 0;
    ai = sum(I(ib1 == 1),'all')/sum(ib1,'all');
    bi = sum(I(ib2 == 1),'all')/sum(ib2,'all');
    m = (ai+bi)/2;
    mcurr = m;
    I1 = repeatedSegmentation (ib1, iv1, mcurr, m, II, R, C, 1, 0);
    I2 = repeatedSegmentation (ib2, iv2, mcurr, m, II, R, C, 0, 1);
    IOUT(:,:,i) = uint8((I1+I2)*255);
end
subplot(1,2,1);
imshow(I);
title('Original Image');
subplot(1,2,2);
imshow(IOUT);
title('Repeated Segmentation Result');
imwrite(IOUT,'Output_Q4_RepeatedSegmentation.jpg');

function IMG = repeatedSegmentation (ibin, ival, mcurr, m, I, R, C, mn, mx)
   if (mcurr < 0.1*m)
       IMG = ival;
       return;
   end
   ITemp1 = zeros(R,C); ITemp2 = zeros(R,C); ibin1 = zeros(R,C); ibin2 = zeros(R,C);
   if (mn < mx)
       ITemp1((I < mcurr)&(ibin == 1)) = mn;
       ITemp2((I >= mcurr)&(ibin == 1)) = mn+(mx-mn)/4;
   else
       ITemp1((I < mcurr)&(ibin == 1)) = mn-(mn-mx)/4;
       ITemp2((I >= mcurr)&(ibin == 1)) = mn;
   end
   ibin1((I < mcurr)&(ibin == 1)) = 1;
   ibin2((I >= mcurr)&(ibin == 1)) = 1;
   if (sum(ibin1,'all') ~= 0)
       a1 = sum(I(ibin1 == 1),'all')/sum(ibin1,'all');
   else
       a1 = 0;
   end
   if (sum(ibin2,'all') ~= 0)
       b1 = sum(I(ibin2 == 1),'all')/sum(ibin2,'all');
   else
       b1 = 0;
   end
   nmcurr = (a1+b1)/2;
   if (nmcurr == mcurr)
       IMG = ival;
       return;
   end
   xx = min(mn,mx);
   yy = max(mn,mx);
   IA = repeatedSegmentation (ibin1, ITemp1, nmcurr, m, I, R, C, xx, xx+(yy-xx)/4);
   IB = repeatedSegmentation (ibin2, ITemp2, nmcurr, m, I, R, C, yy-(yy-xx)/4, yy);
   IMG = IA+IB;
   return;
end