function [resImg,midImg] = detectEdge(rawImg,detector,varargin)
%DETECTEDGE 此处显示有关此函数的摘要
%   此处显示详细说明

if nargin<2
    error('Wrong parameters!');
end

rawImg=mat2gray(rawImg);
resImg=false(size(rawImg));

switch lower(detector)
    case {'roberts','prewitt','sobel'}
        % Basic edge detection.
        % initialize parameters.
        if nargin>4
            error('Wrong parameters!');
        end
        if nargin<3
            avgMask=1/25*ones(5);
        else
            avgSize=varargin{1};
            avgMask=1/avgSize^2*ones(avgSize);
        end
        if nargin<4
            ratio=1/3;
        else
            ratio=varargin{2};
        end
        if nargout>1
            error('Too many outputs!');
        end
        
        % Use average filter and different gradient filter.
        imgData=dipLinearFilter(rawImg,avgMask);
        switch lower(detector(1))
            case 'r'
                mask1=[-1,0;0,1];mask2=[0,-1;1,0];
            case 'p'
                mask1=[-1,-1,-1;0,0,0;1,1,1];
                mask2=[-1,0,1;-1,0,1;-1,0,1];
            case 's'
                mask1=[-1,-2,-1;0,0,0;1,2,1];
                mask2=[-1,0,1;-2,0,2;-1,0,1];
        end
        gx=dipLinearFilter(imgData,mask1);
        gy=dipLinearFilter(imgData,mask2);
        mag=abs(gx)+abs(gy);
        maxVal=max(max(mag));
        mask=mag>=maxVal*ratio;
        resImg(mask)=true;
        
    case 'mh'
        % Marr-Hildreth edge detector.
        % Initialize parameters.
        if nargin>5
            error('Wrong parameters!');
        end
        if nargin<3
            csigma=4;
        else
            csigma=varargin{1};
        end
        if nargin<4
            n=round(6*csigma);
            if mod(n,2)==0
                n=n+1;
            end
        else
            n=varargin{2};
        end
        if nargin<5
            ratio=0.09;
        else
            ratio=varargin{3};
        end
        
        % Step1: Use gaussian lowpass filter.
        shift=(n+1)/2;
        x=1:n;
        [y,x]=meshgrid(x-shift,x-shift);
        Gmask=exp(-(x.^2+y.^2)/(2*csigma^2));
        imgData=dipLinearFilter(rawImg,Gmask);
        
        % Step2: Compute the Laplacian.
        Lmask=[1,1,1;1,-8,1;1,1,1];
        imgData=dipLinearFilter(imgData,Lmask);
        midImg=imgData;
        
        % Step3: Find the zero crossings.
        [M,N]=size(rawImg);
        x=2:M-1;y=2:N-1;
        [y,x]=meshgrid(y,x);
        inds=(y-1)*M+x;
        indvec=inds(:)';
        halfNeigh1=[indvec-M-1;indvec-1;indvec+M-1;indvec-M];
        halfNeigh2=[indvec+M+1;indvec+1;indvec-M+1;indvec+M];
        mask1=imgData(halfNeigh1).*imgData(halfNeigh2)<0;
        maxVal=max(max(imgData));
        mask2=abs(imgData(halfNeigh1)-imgData(halfNeigh2))>ratio*maxVal;
        mask=sum(mask1&mask2)>0;
        resImg(indvec(mask))=true;
        
    case 'canny'
        % Canny edge detector.
        % Initialize parameters.
        if nargin>6
            error('Wrong parameters!');
        end
        if nargin<3
            csigma=4;
        else
            csigma=varargin{1};
        end
        if nargin<4
            n=round(6*csigma);
            if mod(n,2)==0
                n=n+1;
            end
        else
            n=varargin{2};
        end
        if nargin<5
            TL=2.3;
        else
            TL=varargin{3};
        end
        if nargin<6
            TH=2.5*TL;
        else
            TH=varargin{4};
        end
        if nargout>1
            error('Too many outputs!');
        end
        
        % Step1: Use gaussian lowpass filter.
        shift=(n+1)/2;
        x=1:n;
        [y,x]=meshgrid(x-shift,x-shift);
        Gmask=exp(-(x.^2+y.^2)/(2*csigma^2));
        imgData=dipLinearFilter(rawImg,Gmask);
        
        % Step2: Compute the gradient magnitude and angle images.
        mask1=[-1,-2,-1;0,0,0;1,2,1];
        mask2=[-1,0,1;-2,0,2;-1,0,1];
        gx=dipLinearFilter(imgData,mask1);
        gy=dipLinearFilter(imgData,mask2);
        mag=sqrt(gx.^2+gy.^2);
        ang=atan(gy./gx);
        
        % Step3: Apply nonmaxima suppression.
        mag=padarray(mag,[1,1],0,'both');
        [M,N]=size(mag);
        x=2:M-1;y=2:N-1;
        [y,x]=meshgrid(y,x);
        inds=(y-1)*M+x;
        targNeigh1=zeros(size(inds));
        targNeigh2=zeros(size(inds));
        maskV=ang>=-pi/8&ang<pi/8;
        maskD=ang>=pi/8&ang<pi*3/8;
        maskD_=ang>=-pi*3/8&ang<-pi/8;
        maskH=ang>=pi*3/8|ang<-pi*3/8;
        targNeigh1(maskV)=inds(maskV)-1;targNeigh2(maskV)=inds(maskV)+1;
        targNeigh1(maskD)=inds(maskD)-M-1;targNeigh2(maskD)=inds(maskD)+M+1;
        targNeigh1(maskD_)=inds(maskD_)+M-1;targNeigh2(maskD_)=inds(maskD_)-M+1;
        targNeigh1(maskH)=inds(maskH)-M;targNeigh2(maskH)=inds(maskH)+M;
        mask=mag(inds)<mag(targNeigh1)|mag(inds)<mag(targNeigh2);
        mag(inds(mask))=0;
        gN=mag;
        
        % Step4: Use double thresholding and connectivity analysis.
        gNH=gN>=TH;
        gNL=gN>=TL&(~gNH);
        indvec=inds(gNH(2:end-1,2:end-1))';
        travelMat=true(size(gNH));
        for k=1:numel(indvec)
            if travelMat(indvec(k))
                que=indvec(k);
                travelMat(indvec(k))=false;
            end
            while ~isempty(que)
                curind=que(1);
                que(1)=[];
                curNeigh=[curind-M-1,curind-1,curind+M-1,curind-M,...
                    curind+M,curind-M+1,curind+1,curind+M+1];
                mask1=gNH(curNeigh);
                mask2=gNL(curNeigh);
                mask3=travelMat(curNeigh);
                mask1=mask1&mask3;mask2=mask2&mask3;
                que=[que,curNeigh(mask1|mask2)];
                travelMat(curNeigh(mask1|mask2))=false;
            end
        end
        resImg=~travelMat(2:end-1,2:end-1);
        
    otherwise
        error('Unknown detector name!');
end

end