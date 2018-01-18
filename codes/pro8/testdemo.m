%%Opening by reconstruction
rawImg=imread('../../images/Fig0929(a)(text_image).tif');
figure(1);
suptitle('Opening by reconstruction');
subplot(2,2,1);
imshow(rawImg);
xlabel('origin image');drawnow;
b=dipErode(rawImg,ones(51,1));
subplot(2,2,2);
imshow(b);
xlabel('eroded image');drawnow;
c=dipDilate(b,ones(51,1));
subplot(2,2,3);
imshow(c);
xlabel('opening of origin image');drawnow;
d=dipReconstruct(b,rawImg);
subplot(2,2,4);
imshow(d);
xlabel('result of opening by reconstruction');drawnow;

%%Filling holes
rawImg=imread('../../images/Fig0931(a)(text_image).tif');
figure(2);
suptitle('Filling holes');
subplot(2,2,1);
imshow(rawImg);
xlabel('origin image');drawnow;
[d,b,c]=dipFilling(rawImg);
subplot(2,2,2);
imshow(b);
xlabel('complement of origin image');drawnow;
subplot(2,2,3);
imshow(c);
xlabel('marker image');drawnow;
subplot(2,2,4);
imshow(d);
xlabel('result of hole-filling');drawnow;

%%Border clearing
[b,a]=dipBorderClr(rawImg);
figure(3);
suptitle('Border clearing');
subplot(1,2,1);
imshow(a);
xlabel('result of reconstruction');drawnow;
subplot(1,2,2);
imshow(b);
xlabel('result of border clearing');drawnow;