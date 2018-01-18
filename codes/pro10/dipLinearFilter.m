function [ resdata ] = dipLinearFilter( rawImg, mask )
%DIPLINEARFILTER Compute the linear filter result in relative way.

masksize=size(mask);
imgsize=size(rawImg);
prePad=floor((masksize-1)/2);
postPad=masksize-1-prePad;
img=padarray(double(rawImg),prePad,'symmetric','pre');
img=padarray(img,postPad,'symmetric','post');
resdata=zeros(imgsize);
for k=1:imgsize(1)
    for m=1:imgsize(2)
        resdata(k,m)=sum(sum(img(k:k+masksize(1)-1,m:m+masksize(2)-1).*mask));
    end
end

end