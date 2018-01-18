function [ imagedata, bitnum, plotflag ] = handleparas( varargin )
%HANDLEPARAS Process the parameters.
% Handled parameters are IMAGEDATA, BITNUM, PLOTFLAG. IMAGEDATA is the
% target image data. BITNUM and PLOTFLAG are both optional parameters,
% which are 8 and true respectively by default. BITNUM is the number of bit
% you use to denote a pixel in your image, and plotflag controls the show
% of image in the digital image processing function.

if nargin==0 || nargin>3
    error('Wrong parameters!');
end
imagedata=varargin{1};
bitnum=8;
plotflag=true;
if nargin>1
    bitnum=varargin{2};
end
if nargin>2
    plotflag=varargin{3};
end

end

