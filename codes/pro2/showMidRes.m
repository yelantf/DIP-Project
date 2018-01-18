function showMidRes( resdata, bitnum )
%SHOWMIDRES Show temporary result(laplacian or soble gradient) as an image.

graylevel=2^bitnum;
resdata=double(resdata);
resdata=resdata-min(resdata(:));
resdata=uint16(resdata);
imshow(resdata,[0 graylevel-1]);
end

