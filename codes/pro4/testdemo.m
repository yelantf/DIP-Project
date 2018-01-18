%% Test the noise generator function.
bitnum=8;
graylevel=2^bitnum;
orgpattern=imread('../../images/Fig0503 (original_pattern).tif');
[M,N]=size(orgpattern);

noise=genGaussian(M,N,-0.1,0.1);
newpattern=round(double(orgpattern)+noise*(graylevel-1));
subplot(4,3,4);
my_hist(newpattern);
subplot(4,3,1);
imshow(uint8(newpattern));
title('Gaussian');drawnow;

noise=genRayleigh(M,N,-0.3,0.04);
newpattern=round(double(orgpattern)+noise*(graylevel-1));
subplot(4,3,5);
my_hist(newpattern);
subplot(4,3,2);
imshow(uint8(newpattern));
title('Rayleigh');drawnow;

noise=genGamma(M,N,15,2);
newpattern=round(double(orgpattern)+noise*(graylevel-1));
subplot(4,3,6);
my_hist(newpattern);
subplot(4,3,3);
imshow(uint8(newpattern));
title('Gamma');drawnow;

noise=genExponential(M,N,15);
newpattern=round(double(orgpattern)+noise*(graylevel-1));
subplot(4,3,10);
my_hist(newpattern);
subplot(4,3,7);
imshow(uint8(newpattern));
title('Exponential');drawnow;

noise=genUniform(M,N,-0.1,0.2);
newpattern=round(double(orgpattern)+noise*(graylevel-1));
subplot(4,3,11);
my_hist(newpattern);
subplot(4,3,8);
imshow(uint8(newpattern));
title('Uniform');drawnow;

noise=genImpulse(M,N,0.05,0.05);
noise=uint8(noise*(graylevel-1));
newpattern=orgpattern;
mask=((noise==0)|(noise==graylevel-1));
newpattern(mask)=noise(mask);
subplot(4,3,12);
my_hist(newpattern);
subplot(4,3,9);
imshow(uint8(newpattern));
title('Impulse');drawnow;

%% Test mean filters.
orgcircuit=imread('../../images/Circuit.tif');
[M,N]=size(orgcircuit);
figure;
subplot(2,2,1);
imshow(orgcircuit);
title('origin image');drawnow;

noise=genGaussian(M,N,0,sqrt(400)/(graylevel-1));
noisecircuit=uint8(round(double(orgcircuit)+noise*(graylevel-1)));
subplot(2,2,2);
imshow(noisecircuit);
title('corrupted by gaussian noise');drawnow;

newcircuit=uint8(meanFilter(noisecircuit,'arithmetic',3,3));
subplot(2,2,3);
imshow(newcircuit);
title('3x3 arithmetic mean filter');drawnow;

newcircuit=uint8(meanFilter(noisecircuit,'geometric',3,3));
subplot(2,2,4);
imshow(newcircuit);
title('3x3 geometric mean filter');drawnow;

figure;
noise=genImpulse(M,N,0.1,0.1);
noise=uint8(noise*(graylevel-1));
pepperCircuit=orgcircuit;
pepperCircuit(noise==0)=0;
subplot(2,3,1);
imshow(pepperCircuit);
title('corrupted by pepper noise');drawnow;

saltCircuit=orgcircuit;
saltCircuit(noise==graylevel-1)=graylevel-1;
subplot(2,3,4);
imshow(saltCircuit);
title('corrupted by salt noise');drawnow;

newcircuit=uint8(meanFilter(pepperCircuit,'contraharmonic',3,3,1.5));
subplot(2,3,2);
imshow(newcircuit);
title('3x3 contraharmonic mean filter(Q=1.5) of pepper');drawnow;

newcircuit=uint8(meanFilter(saltCircuit,'contraharmonic',3,3,-1.5));
subplot(2,3,5);
imshow(newcircuit);
title('3x3 contraharmonic mean filter(Q=-1.5) of salt');drawnow;

newcircuit=uint8(meanFilter(pepperCircuit,'contraharmonic',3,3,-1.5));
subplot(2,3,3);
imshow(newcircuit);
title('3x3 contraharmonic mean filter(Q=-1.5) of pepper');drawnow;

newcircuit=uint8(meanFilter(saltCircuit,'contraharmonic',3,3,1.5));
subplot(2,3,6);
imshow(newcircuit);
title('3x3 contraharmonic mean filter(Q=1.5) of salt');drawnow;

%% Test order filters.
figure;
noise=genImpulse(M,N,0.1,0.1);
noise=uint8(noise*(graylevel-1));
peppersalt=orgcircuit;
mask=noise==0|noise==graylevel-1;
peppersalt(mask)=noise(mask);
subplot(2,2,1);
imshow(peppersalt);
title('corrupted by salt and pepper noise');drawnow;

newcircuit=uint8(orderFilter(peppersalt,'median',3,3));
subplot(2,2,2);
imshow(newcircuit);
title('once 3x3 median filter');drawnow;

newcircuit=uint8(orderFilter(newcircuit,'median',3,3));
subplot(2,2,3);
imshow(newcircuit);
title('twice 3x3 median filter');drawnow;

newcircuit=uint8(orderFilter(newcircuit,'median',3,3));
subplot(2,2,4);
imshow(newcircuit);
title('3 times 3x3 median filter');drawnow;

figure;
subplot(2,2,1);
imshow(pepperCircuit);
title('corrupted by pepper noise');drawnow;
subplot(2,2,3);
imshow(saltCircuit);
title('corrupted by salt noise');drawnow;

newcircuit=uint8(orderFilter(pepperCircuit,'max',3,3));
subplot(2,2,2);
imshow(newcircuit);
title('3x3 max filter');drawnow;

newcircuit=uint8(orderFilter(saltCircuit,'min',3,3));
subplot(2,2,4);
imshow(newcircuit);
title('3x3 min filter');drawnow;

%% Compare two kinds of filters.
figure;
b=sqrt(800*12/4)/(graylevel-1);a=-b;
noise=genUniform(M,N,a,b);
noisecircuit=uint8(round(double(orgcircuit)+noise*(graylevel-1)));
subplot(2,3,1);
imshow(noisecircuit);
title('corrupted by uniform noise');drawnow;

noise=genImpulse(M,N,0.1,0.1);
noise=uint8(noise*(graylevel-1));
compnoise=noisecircuit;
mask=(noise==0|noise==graylevel-1);
compnoise(mask)=noise(mask);
subplot(2,3,2);
imshow(compnoise);
title('corrupted by uniform and pepper&salt noise');drawnow;

newcircuit=uint8(meanFilter(compnoise,'arithmetic',5,5));
subplot(2,3,3);
imshow(newcircuit);
title('5x5 arithmetic mean filter');drawnow;

newcircuit=uint8(meanFilter(compnoise,'geometric',5,5));
subplot(2,3,4);
imshow(newcircuit);
title('5x5 geometric mean filter');drawnow;

newcircuit=uint8(orderFilter(compnoise,'median',5,5));
subplot(2,3,5);
imshow(newcircuit);
title('5x5 median filter');drawnow;

newcircuit=uint8(orderFilter(compnoise,'alphamean',5,5,10));
subplot(2,3,6);
imshow(newcircuit);
title('5x5 alpha-trimmed filter(d=10)');drawnow;