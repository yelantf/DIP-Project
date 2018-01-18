function [ resdata ] = dipLaplacian( varargin )
%DIPLAPLACIAN Compute the laplacian of an image.
%   resdata = DIPLAPLACIAN( IMAGEDATA, BITNUM, PLOTFLAG )
%   Will return the final result of laplacian. The parameters are handled
%   with function handleparas. You can use 'help handleparas' to know more
%   details. a,b are respectively 0 and 1 by default.

%% Handle the parameters.
[imgdata, bitnum, plotflag]=handleparas(varargin{:});

%% Compute the laplacian.
mask=[0 -1 0; -1 4 -1; 0 -1 0];
resdata=dipLinearFilter(imgdata,mask);

%% Try to plot the laplacian.
if plotflag
    showMidRes(resdata,bitnum);
end

