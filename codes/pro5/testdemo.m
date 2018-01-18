rawImg=imread('../../images/book_cover.jpg');
bitnum=8;graylevel=2^bitnum;
figure(1);
suptitle('Motion blur');
subplot(1,3,1);
imshow(rawImg);
xlabel('Origin image');drawnow;

a=0.1;b=0.1;T=1;
blurImg=dipFreqFilter(rawImg,'motion',a,b,T);
subplot(1,3,2);
imshow(uint16(blurImg),[0 graylevel-1]);
xlabel('Blurred image with a=b=0.1 and T=1');drawnow;

a=0.05;b=0.05;T=1;
blurImg=dipFreqFilter(rawImg,'motion',a,b,T);
subplot(1,3,3);
imshow(uint16(blurImg),[0 graylevel-1]);
xlabel('Blurred image with a=b=0.05 and T=1');drawnow;

blurImg=mat2gray(blurImg,[0 graylevel-1]);
[M,N]=size(blurImg);

rawImg=mat2gray(rawImg,[0 255]);
rawDFT=dip2DDFT(rawImg);
rawSpec=rawDFT.*conj(rawDFT);
rawSum=sum(sum(rawSpec));

noiseData=genGaussian(M,N,0,sqrt(650)/(graylevel-1));
noiseImg=mat2gray(blurImg+noiseData,[0,1]);
figure(2);
suptitle('Comparison between inverse filter and Wiener filter');
subplot(3,3,1);
imshow(noiseImg);
xlabel('blurred image + guassian noise(mean=0,var=650)');drawnow;
restImg=dipFreqFilter(noiseImg,'rmotion',a,b,T);
figure(2);
subplot(3,3,2);
imshow(restImg);
xlabel('result of inverse filtering');drawnow;
noiseDFT=dip2DDFT(noiseData);
noiseSpec=noiseDFT.*conj(noiseDFT);
noiseSum=sum(sum(noiseSpec));
K=noiseSum/rawSum;
restImg=dipFreqFilter(noiseImg,'Wiener',K,a,b,T);
figure(2);
subplot(3,3,3);
imshow(restImg);
xlabel(['result of Wiener filtering with K=',num2str(K,'%.2g')]);drawnow;
restImg=dipFreqFilter(noiseImg,'rmotion',a,b,T,90,10);
figure(3);
suptitle('inverse filter+Butterworth filter');
subplot(1,3,1);
imshow(restImg);
xlabel('restored image of noise image in figure 2(mean=0,var=650)');drawnow;

noiseData=genGaussian(M,N,0,sqrt(65)/(graylevel-1));
noiseImg=mat2gray(blurImg+noiseData,[0,1]);
figure(2);
subplot(3,3,4);
imshow(noiseImg);
xlabel('blurred image + guassian noise(mean=0,var=65)');drawnow;
restImg=dipFreqFilter(noiseImg,'rmotion',a,b,T);
figure(2);
subplot(3,3,5);
imshow(restImg);
xlabel('result of inverse filtering');drawnow;
noiseDFT=dip2DDFT(noiseData);
noiseSpec=noiseDFT.*conj(noiseDFT);
noiseSum=sum(sum(noiseSpec));
K=noiseSum/rawSum;
restImg=dipFreqFilter(noiseImg,'Wiener',K,a,b,T);
figure(2);
subplot(3,3,6);
imshow(restImg);
xlabel(['result of Wiener filtering with K=',num2str(K,'%.2g')]);drawnow;
restImg=dipFreqFilter(noiseImg,'rmotion',a,b,T,90,10);
figure(3);
subplot(1,3,2);
imshow(restImg);
xlabel('restored image of noise image in figure 2(mean=0,var=65)');drawnow;

noiseData=genGaussian(M,N,0,sqrt(650e-5)/(graylevel-1));
noiseImg=mat2gray(blurImg+noiseData,[0,1]);
figure(2);
subplot(3,3,7);
imshow(noiseImg);
xlabel('blurred image + guassian noise(mean=0,var=0.0065)');drawnow;
restImg=dipFreqFilter(noiseImg,'rmotion',a,b,T);
figure(2);
subplot(3,3,8);
imshow(restImg);
xlabel('result of inverse filtering');drawnow;
noiseDFT=dip2DDFT(noiseData);
noiseSpec=noiseDFT.*conj(noiseDFT);
noiseSum=sum(sum(noiseSpec));
K=noiseSum/rawSum;
restImg=dipFreqFilter(noiseImg,'Wiener',K,a,b,T);
figure(2);
subplot(3,3,9);
imshow(restImg);
xlabel(['result of Wiener filtering with K=',num2str(K,'%.2g')]);drawnow;
restImg=dipFreqFilter(noiseImg,'rmotion',a,b,T,90,10);
figure(3);
subplot(1,3,3);
imshow(restImg);
xlabel('restored image of noise image in figure 2(mean=0,var=0.0065)');drawnow;