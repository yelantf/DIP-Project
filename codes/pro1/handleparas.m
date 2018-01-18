function [ imagedata, bitnum, plotflag ] = handleparas( varargin )
%HANDLEPARAS Process the parameters.

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

