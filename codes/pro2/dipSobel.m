function [ resdata ] = dipSobel( varargin )
%DIPSOBEL Compute the gradient of an image with soble mask.
%   resdata = DIPSOBEL( IMAGEDATA, BITNUM, PLOTFLAG )
%   Will return the final result of gradient. The parameters are handled
%   with function handleparas. You can use 'help handleparas' to know more
%   details.

%% Handle the parameters.
[imgdata, bitnum, plotflag]=handleparas(varargin{:});

%% Compute the gradient.
mask=[-1 -2 -1; 0 0 0;1 2 1];
grax=dipLinearFilter(imgdata, mask);
mask=[-1 0 1; -2 0 2; -1 0 1];
gray=dipLinearFilter(imgdata, mask);
resdata=abs(grax)+abs(gray);
%resdata=sqrt(grax.^2+gray.^2);

%% Try to plot the laplacian.
if plotflag
    showMidRes(resdata,bitnum);
end

end

