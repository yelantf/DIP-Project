bitnum=8;
graylevel=2^bitnum;

img=imread('../../images/fig1.jpg');
[data,tmpy,tmpx]=b_equalization(img,bitnum);
figure;
stairs(tmpx,tmpy);
xlim([0 graylevel-1]);
set(gca,'XTick',[0:graylevel/8:graylevel-1 graylevel-1]);
title('transformation function of fig1');drawnow;

img=imread('../../images/fig2.jpg');
figure;
[data,tmpy,tmpx]=b_equalization(img,bitnum);
figure;
stairs(tmpx,tmpy);
xlim([0 graylevel-1]);
set(gca,'XTick',[0:graylevel/8:graylevel-1 graylevel-1]);
title('transformation function of fig2');drawnow;