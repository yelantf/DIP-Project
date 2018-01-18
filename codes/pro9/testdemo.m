rawImg=imread('../../images/building.tif');
rawImg=mat2gray(rawImg);
figure(1);
suptitle('Comparison between different edge detectors');
subplot(2,3,1);
imshow(rawImg);
xlabel('origin image scaled to [0,1]');
drawnow;

resImg=detectEdge(rawImg,'Roberts');
subplot(2,3,4);
imshow(resImg);
xlabel('5x5 average filter + Roberts mask');
drawnow;

resImg=detectEdge(rawImg,'Prewitt');
subplot(2,3,5);
imshow(resImg);
xlabel('5x5 average filter + Prewitt mask');
drawnow;

resImg=detectEdge(rawImg,'Sobel');
subplot(2,3,6);
imshow(resImg);
xlabel('5x5 average filter + Sobel mask');
drawnow;

resImg=detectEdge(rawImg,'MH');
subplot(2,3,2);
imshow(resImg);
xlabel('the Marr-Hildreth algorithm');
drawnow;

resImg=detectEdge(rawImg,'Canny');
subplot(2,3,3);
imshow(resImg);
xlabel('the Canny algorithm');
drawnow;

rawImg=imread('../../images/polymersomes.tif');
bitnum=8;graylevel=2^bitnum;
figure(2);
suptitle('Thresholding');
subplot(2,2,1);
imshow(uint16(rawImg),[0,graylevel-1]);
xlabel('origin image');
drawnow;

[freq,inte]=dipHistogram(rawImg,bitnum);
subplot(2,2,2);
plotbar(inte,freq,bitnum);
xlabel('histogram of origin image')
drawnow;

[resImg,T,yita]=dipThresholding(rawImg,'basic',bitnum);
subplot(2,2,3);
imshow(resImg);
xlabel(['basic global algorithm$(T=' num2str(T) ',\eta=' num2str(yita) ')$'],...
    'Interpreter','latex');
drawnow;

[resImg,T,yita]=dipThresholding(rawImg,'otsu',bitnum);
subplot(2,2,4);
imshow(resImg);
xlabel(['Otsu''s method$(T=' num2str(T) ',\eta=' num2str(yita) ')$'],...
    'Interpreter','latex');
drawnow;