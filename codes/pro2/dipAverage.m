function [ resdata ] = dipAverage( varargin )
%DIPAVERAGE Process an image with a 5x5 average filter.
%   resdata = DIPAVERAGE( IMAGEDATA, BITNUM, PLOTFLAG )
%   Will return the final result of applying average filter. The parameters
%   are handled with function handleparas. You can use 'help handleparas' 
%   to know more details.
%   Note that if you use this function to handle a middle result image, you
%   will need to deactivate the plotflag and show the result with
%   showMidRes by yourself.

%% Handle the parameters.
[imgdata, bitnum, plotflag]=handleparas(varargin{:});

%% Compute the result.
graylevel=2^bitnum;
mask=1/25*ones(5);
resdata=dipLinearFilter(imgdata,mask);

%% Try to show the result image.
if plotflag
    imshow(uint16(resdata),[0 graylevel-1]);
end

end

