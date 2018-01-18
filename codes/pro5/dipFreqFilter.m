function [resdata, orgSpectrum, resSpectrum] = dipFreqFilter(rawImg,typename,varargin)
%MOTIONBLUR 此处显示有关此函数的摘要
%   此处显示详细说明

%% Handle the parameters.
switch lower(typename)
    case 'motion'
        if nargin~=5
            error('Wrong parameters!');
        end
        [a,b,T]=varargin{:};
    case 'rmotion'
        if nargin~=5&&nargin~=7
            error('Wrong parameters!');
        end
        [a,b,T]=varargin{1:3};
        if nargin==7
            blFlag=true;
            [D0,n]=varargin{4:5};
        else
            blFlag=false;
        end
    case 'wiener'
        if nargin~=6
            error('Wrong parameters!');
        end
        [K,a,b,T]=varargin{:};
    otherwise
        error('Unrecognized filter type!');
end
[M,N]=size(rawImg);
imgData=double(rawImg);
imgData=repmat(imgData,2,2);

%% Multiply the image data by (-1)^(x+y).
x=1:2*N;
pair=[(-1).^(x-1);(-1).^x];
mask=repmat(pair,M,1);
mask=mask(1:2*M,1:2*N);
imgData=imgData.*mask;

%% Do the DFT.
dftRes=dip2DDFT(imgData);
orgSpectrum=abs(dftRes);

%% Calculate H(u,v)F(u,v).
[V,U]=meshgrid(-N:N-1,-M:M-1);
tmpMat=(U*a+V*b)*pi;
H=T.*sin(tmpMat).*exp(-1j*tmpMat)./tmpMat;
H(tmpMat==0)=T;
switch lower(typename)
    case 'rmotion'
        H=1./H;
        H(abs(H)>1e10)=0;
        if blFlag
            D=sqrt(U.^2+V.^2);
            D=1./(1+(D./D0).^(2*n));
            H=H.*D;
        end
    case 'wiener'
        Hstar=conj(H);
        H=Hstar./(Hstar.*H+K);
        H(abs(H)>1e10)=0;
end
productRes=H.*dftRes;
resSpectrum=abs(productRes);

%% Do the IDFT.
idftRes=real(dip2DIDFT(productRes));

%% Multiply the image data by (-1)^(x+y).
resdata=idftRes.*mask;
resdata=resdata(1:M,1:N);

end

