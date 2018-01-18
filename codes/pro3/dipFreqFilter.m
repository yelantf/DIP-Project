function [ resdata, orgSpectrum, resSpectrum ] = dipFreqFilter( varargin )
%DIPFREQFILTER Do filtering on an image in frequency domain.
%   [resdata, orgSpectrum, resSpectrum] = DIPFREQFILTER(IMAGEDATA,
%   FILTERTYPE, FILTERPARAM, BITNUM, PLOTFLAG ) will return the result of 
%   the filtering with a filter specified by the second parameter 
%   FILTERTYPE. And if you want, you can get the Fourier spectrums of the 
%   orgin image and result image. The parameter FILTERTYPE can be specified
%   as 'ILPF', 'BLPF', 'GLPF', 'IHPF', 'BHPF' and 'GHPF'. The parmeter 
%   FILTERPARAM specifies parameters for the filter. For the ideal filters
%   and Gussian filters, it's just D0, but for the Butterworth filters, it
%   should be [D0,n]. You can see more details about other parameters in 
%   the description of function 'handleparas'.

%% Handle the parameters.
if nargin<3
    error('Wrong parameters!');
end
[rawimg, bitnum, plotflag]=handleparas(varargin{1},varargin{4:end});
filterType=varargin{2};
filterparam=varargin{3};
graylevel=2^bitnum;
[imgh,imgw]=size(rawimg);
imgdata=double(rawimg);

%% Multiply the image data by (-1)^(x+y).
x=1:imgw;
pair=[(-1).^(x-1);(-1).^x];
mask=repmat(pair,ceil(imgh/2),1);
mask=mask(1:imgh,1:imgw);
imgdata=imgdata.*mask;

%% Do the DFT.
imgdata(2*imgh,2*imgw)=0;
dftRes=dip2DDFT(imgdata);
orgSpectrum=abs(dftRes);

%% Calculate H(u,v)F(u,v).
[V,U]=meshgrid(0:2*imgw-1,0:2*imgh-1);
D=sqrt(((U-imgh).^2+(V-imgw).^2));

switch filterType
    case {'ILPF','IHPF'}
        H=D<=filterparam(1);
    case {'BLPF','BHPF'}
        if numel(filterparam)<2
            error('Should give a specific n.');
        end
        H=1./(1+(D./filterparam(1)).^(2*filterparam(2)));
    case {'GLPF','GHPF'}
        H=exp(-(D.^2)./(2*(filterparam(1)^2)));
    otherwise
        error('Unknown filter type')
end

if filterType(2)=='H'
    H=1-H;
end

productRes=H.*dftRes;
resSpectrum=abs(productRes);

%% Do the IDFT.
idftRes=real(dip2DIDFT(productRes));
idftRes=idftRes(1:imgh,1:imgw);

%% Multiply the image data by (-1)^(x+y).
resdata=idftRes.*mask;

%% Try to plot the process.
if plotflag
    subplot(2,2,1);
    imshow(rawimg,[0 graylevel-1]);
    subplot(2,2,2);
    showSpectrum(orgSpectrum);
    subplot(2,2,3);
    imshow(uint16(resdata),[0 graylevel-1]);
    subplot(2,2,4);
    showSpectrum(resSpectrum);
end

end

