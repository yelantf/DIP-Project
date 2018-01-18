bitnum=8;graylevel=2^bitnum;
rawImg=imread('../../images/characters_test_pattern.tif');

figure(1);
suptitle('Rotate image with different pad type');
subplot(2,2,1);
imshow(rawImg,[0 graylevel-1]);
xlabel('Origin image');drawnow;

resImg=geoTransform(rawImg,'rotate','bilinear',30,0,0,'black',bitnum);
subplot(2,2,2);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Rotate $30^{\circ}$ with black padded','Interpreter','latex');
drawnow;

resImg=geoTransform(rawImg,'rotate','bilinear',30,0,0,'white',bitnum);
subplot(2,2,3);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Rotate $30^{\circ}$ with white padded','Interpreter','latex');
drawnow;

resImg=geoTransform(rawImg,'rotate','bilinear',30,0,0,'image',bitnum);
subplot(2,2,4);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Rotate $30^{\circ}$ circularly padded','Interpreter','latex');
drawnow;

resImg=geoTransform(rawImg,'rotate','bilinear',30,0,0,'black',bitnum);
figure(2);
suptitle('Rotate image with different center points and angles');
subplot(1,3,1);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Rotate $30^{\circ}$ around (0,0)','Interpreter','latex');
drawnow;

[M,N]=size(rawImg);
resImg=geoTransform(rawImg,'rotate','bilinear',-45,M-1,N-1,'black',bitnum);
subplot(1,3,2);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Rotate $-45^{\circ}$ around (M-1,N-1)','Interpreter','latex');
drawnow;

cx=floor(M/2);cy=floor(N/2);
resImg=geoTransform(rawImg,'rotate','bilinear',60,cx,cy,'black',bitnum);
subplot(1,3,3);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Rotate $60^{\circ}$ around center point of image','Interpreter','latex');
drawnow;

resImg=geoTransform(rawImg,'rotate','nearneighbor',60,cx,cy,'black',bitnum);
figure(3);
suptitle('Rotate image using different interpolation methods');
subplot(1,2,1);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Nearest neighbor');
drawnow;

resImg=geoTransform(rawImg,'rotate','bilinear',60,cx,cy,'black',bitnum);
subplot(1,2,2);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Bilinear');
drawnow;

rawImg=imread('../../images/book_cover.jpg');
figure(4);
suptitle('Translate image with different pad type and displcement');
subplot(2,2,1);
imshow(rawImg,[0 graylevel-1]);
xlabel('Origin image');drawnow;

resImg=geoTransform(rawImg,'translate','bilinear',30,30,'black',bitnum);
subplot(2,2,2);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Translate by (30,30) pixels with black padded');
drawnow;

resImg=geoTransform(rawImg,'translate','bilinear',-30.5,40.3,'white',bitnum);
subplot(2,2,3);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Translate by (-30.5,40.3) pixels with white padded');
drawnow;

resImg=geoTransform(rawImg,'translate','bilinear',80,40,'image',bitnum);
subplot(2,2,4);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Translate by (80,40) pixels with image padded');
drawnow;

resImg=geoTransform(rawImg,'translate','nearneighbor',40.5,40.5,'black',bitnum);
figure(5);
suptitle('Translate image using different interpolation methods');
subplot(1,2,1);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Nearest neighbor');
drawnow;

resImg=geoTransform(rawImg,'translate','bilinear',40.5,40.5,'black',bitnum);
subplot(1,2,2);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Bilinear');
drawnow;

rawImg=imread('../../images/lenna.tif');
figure(6);
imshow(rawImg);
imshow(rawImg,[0 graylevel-1]);
xlabel('Origin image of scale transform');drawnow;

resImg=geoTransform(rawImg,'scale','bilinear',1.5,1.5);
figure(7);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Scale transform with enlarge param=(1.5,1.5)');
drawnow;

resImg=geoTransform(rawImg,'scale','bilinear',0.5,0.5);
figure(8);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Scale transform with enlarge param=(0.5,0.5)');
drawnow;

resImg=geoTransform(rawImg,'scale','bilinear',1,-1);
figure(9);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Scale transform with enlarge param=(1,-1)');
drawnow;

resImg=geoTransform(rawImg,'scale','nearneighbor',2,2);
figure(10);
suptitle('Translate image using different interpolation methods');
subplot(1,2,1);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Nearest neighbor');
drawnow;

resImg=geoTransform(rawImg,'scale','bilinear',2,2);
subplot(1,2,2);
imshow(uint16(resImg),[0 graylevel-1]);
xlabel('Bilinear');
drawnow;