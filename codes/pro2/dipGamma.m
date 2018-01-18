function [ resdata ] = dipGamma( varargin )
%DIPGAMMA Compute the result of gamma transformation with gamma=0.5 and c=1.
%   resdata = DIPGAMMA( IMAGEDATA, BITNUM, PLOTFLAG )
%   Will return the final result of the transformation. The parameters are 
%   handled with function handleparas. You can use 'help handleparas' to 
%   know more details.
%   Note that if you use this function to handle a middle result image, you
%   will need to deactivate the plotflag and show the result with
%   showMidRes by yourself.

%% Handle the parameters.
[imgdata, bitnum, plotflag]=handleparas(varargin{:});

%% Do the transfer.
graylevel=2^bitnum;
img=double(imgdata)/(graylevel-1);
resdata=img.^0.5;
resdata=uint16(resdata*(graylevel-1));

%% Try to show the result image.
if plotflag
    imshow(resdata,[0 graylevel-1]);
end

end

