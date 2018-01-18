bitnum=8;
graylevel=2^bitnum;

img=imread('../../images/skeleton_orig.tif');
subplot(2,4,1);
imshow(img,[0 graylevel-1]);
title('(a) Origin image');drawnow;

subplot(2,4,2);
lapla=dipLaplacian(img,bitnum,false);
showMidRes(lapla,bitnum);
title('(b) Laplacian of (a)');drawnow;

subplot(2,4,3);
imgc=uint16(double(img)+lapla);
imshow(imgc,[0 graylevel-1]);
title('(c) Sum of (a) and (b)');drawnow;

subplot(2,4,4);
sobimg=dipSobel(img,bitnum,false);
showMidRes(sobimg,bitnum);
title('(d) Sobel of (a)');drawnow;

subplot(2,4,5);
avgimg=dipAverage(sobimg,bitnum,false);
showMidRes(avgimg,bitnum);
title('(e) Smooth (d) with a 5x5 average filter');drawnow;

subplot(2,4,6);
imgf=double(imgc).*double(avgimg)/(graylevel-1);
showMidRes(imgf,bitnum);
title('(f) Product of (c) and (e)');drawnow;

subplot(2,4,7);
imgg=uint16(double(img)+imgf);
imshow(imgg,[0 graylevel-1]);
title('(g) Sum of (a) and (f)');drawnow;

subplot(2,4,8);
gamimg=dipGamma(imgg,bitnum,false);
imshow(gamimg,[0 graylevel-1]);
title('(h) Gamma transformation result of (g)');drawnow;