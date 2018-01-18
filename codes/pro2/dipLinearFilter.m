function [ resdata ] = dipLinearFilter( imgdata, mask )
%DIPLINEARFILTER Compute the linear filter result in relative way.

masksize=size(mask);
imgsize=size(imgdata);
prePad=floor((masksize-1)/2);
img=zeros(imgsize+masksize-1);
img(prePad(1)+1:prePad(1)+imgsize(1),prePad(2)+1:prePad(2)+imgsize(2))=double(imgdata);
resdata=zeros(imgsize);
for k=1:imgsize(1)
    for m=1:imgsize(2)
        resdata(k,m)=sum(sum(img(k:k+masksize(1)-1,m:m+masksize(2)-1).*mask));
    end
end

end

