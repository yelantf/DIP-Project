bitnum=8;graylevel=2^bitnum;
rawImg=imread('../../images/noisy_stroke.tif');

figure(1);
suptitle('Freeman chain code');
subplot(2,3,1);
imshow(rawImg);
xlabel('origin image');drawnow;

avgFilter=1/81*ones(9);
b=dipLinearFilter(rawImg,avgFilter);
subplot(2,3,2);
imshow(uint16(b),[0 graylevel-1]);
xlabel('image smoothed with 9x9 averaging mask');drawnow;

c=dipThresholding(uint16(b),'Otsu',bitnum);
subplot(2,3,3);
imshow(c);
xlabel('image thresholded using Otsu¡¯s method');drawnow;

[d,bd]=bdFollow(c);
subplot(2,3,4);
imshow(d);
xlabel('outer boundary using boundary following algorithm');drawnow;

[e,grids,f]=dipResample(bd,50,size(rawImg));
subplot(2,3,5);
imshow(e);
xlabel('Subsampled boundary with grid scale=50px');drawnow;
subplot(2,3,6);
imshow(f);
xlabel('Connected image of resampled boundary');drawnow;

[cd,s,diffcd,normcd,ns,ndiffcd]=dipChainCode(grids);
fprintf('For image noisy_stroke.tif:\n');
fprintf('Default 8-directional chain code start with (%d,%d):\n',s(1),s(2));
fprintf(num2str(cd,'%d '));
fprintf('\nand its first difference is:\n');
fprintf(num2str(diffcd,'%d '));
fprintf('\n Normalized 8-directional chain code starts with (%d,%d), its value is:\n',ns(1),ns(2));
fprintf(num2str(normcd,'%d '));
fprintf('\nand its first difference is:\n');
fprintf(num2str(ndiffcd,'%d '));
fprintf('\n');

bitnum=8;graylevel=2^bitnum;
imgpath='../../images/washingtonDC/WashingtonDC_Band';
labels={'visible blue','visible green','visible red',...
    'near infrared','middle infrared','thermal infrared bands'};
figure(2);
suptitle('Origin multispectral images');
for k=1:6
    imgData(:,:,k)=imread([imgpath,num2str(k),'.tif']);
    subplot(2,3,k);
    imshow(imgData(:,:,k));
    xlabel(labels{k});drawnow;
end
sz=size(imgData(:,:,1));
[y,x,A,Cy]=dipPC(imgData);
eigVal=diag(Cy);
fprintf('Eigenvalues of the covariance matrices obtained from all 6 images:\n');
figure(3);
suptitle('Principal component images');
for k=1:6
    subplot(2,3,k);
    curImg=reshape(y(k,:),sz);
    imshow(curImg,[]);
    xlabel(labels{k});drawnow;
    fprintf('lambda_%d=%f\n',k,eigVal(k));
end
[y,x]=dipPC(imgData,2);
figure(4);
suptitle('Images reconstructed using only 2 PCs with largest eigenvalues');
figure(5);
suptitle('Differences between the original and reconstructed images');
for k=1:6
    figure(4);
    subplot(2,3,k);
    curImg=reshape(x(k,:),sz);
    imshow(uint16(curImg),[0 graylevel-1]);
    xlabel(labels{k});drawnow;
    diffImg=double(imgData(:,:,k))-curImg;
    figure(5);
    subplot(2,3,k);
    imshow(diffImg,[]);
    xlabel(labels{k});drawnow;
end