function [resImg] = geoTransform(rawImg,transform,interType,varargin)
%GEOTRANSFORM 此处显示有关此函数的摘要
%   此处显示详细说明

switch lower(transform)
    case 'rotate'
        if nargin<6
            error('Wrong parameters!');
        end
        [angle,centerX,centerY]=varargin{1:3};
        if nargin<7
            padType='black';
        else
            padType=varargin{4};
        end
        if nargin<8
            bitnum=8;
        else
            bitnum=varargin{5};
        end
    case 'translate'
        if nargin<5
            error('Wrong parameters!');
        end
        [xshift,yshift]=varargin{1:2};
        if nargin<6
            padType='black';
        else
            padType=varargin{3};
        end
        if nargin<7
            bitnum=8;
        else
            bitnum=varargin{4};
        end
    case 'scale'
        if nargin<4
            error('Wrong parameters!');
        end
        xscale=varargin{1};
        if nargin<5
            yscale=xscale;
        else
            yscale=varargin{2};
        end
        bitnum=8;
    otherwise
        error('Unknown geometric transformation!');
end

switch lower(interType)
    case 'nearneighbor'
        interlv=0;
    case 'bilinear'
        interlv=1;
    otherwise
        error('Unknown interpolation methods!');
end

imgData=double(rawImg);
graylevel=2^bitnum;
[M,N]=size(imgData);

switch lower(transform)
    case 'rotate'
        [Y,X]=meshgrid(1:N,1:M);
        theta=mod(angle,360)*pi/180;
        tmpX=X-centerX-1;tmpY=Y-centerY-1;
        newX=tmpX*cos(theta)-tmpY*sin(theta)+centerX+1;
        newY=tmpX*sin(theta)+tmpY*cos(theta)+centerY+1;
        resImg=interProcess(newX,newY,imgData,interlv,padType,graylevel);
    case 'translate'
        [Y,X]=meshgrid(1:N,1:M);
        newX=X-xshift;
        newY=Y-yshift;
        resImg=interProcess(newX,newY,imgData,interlv,padType,graylevel);
    case 'scale'
        [Y,X]=meshgrid(1:abs(yscale)*N,1:abs(xscale)*M);
        newX=(X-1)/xscale+1;newY=(Y-1)/yscale+1;
        if xscale<0
            newX=newX-1;
        end
        if yscale<0
            newY=newY-1;
        end
        resImg=interProcess(newX,newY,imgData,interlv,'image',graylevel);
end
end

function interData=interProcess(newX,newY,imgData,interlv,padType,graylevel)
[M,N]=size(imgData);
switch lower(padType)
    case 'black'
        imgData=padarray(imgData,[1 1],0,'both');
        newX=newX+1;newY=newY+1;
        exMask=newX<=1|newX>M+2|newY<=1|newY>N+2;
        newX(exMask)=1;newY(exMask)=1;
    case 'white'
        imgData=padarray(imgData,[1 1],graylevel-1,'both');
        newX=newX+1;newY=newY+1;
        exMask=newX<=1|newX>M+2|newY<=1|newY>N+2;
        newX(exMask)=1;newY(exMask)=1;
    case 'image'
        imgData=padarray(imgData,[1 1],'circular','both');
        newX=mod(newX-1,M)+1;newY=mod(newY-1,N)+1;
        newX=newX+1;newY=newY+1;
    otherwise
        error('Unknown pad type!');
end

if interlv==0
    interData=dipInterp0(imgData,newX,newY);
elseif interlv==1
    interData=dipInterp1(imgData,newX,newY);
end
end