function [resData] = DCTCompress(rawimg, maskType, Ztimes)
%DCTCOMPRESS 此处显示有关此函数的摘要
%   此处显示详细说明

%% Handle parameters.
if nargin<2||nargin>3
    error('Wrong parameters!');
end
if nargin<3
    Ztimes=1;
end
[M,N]=size(rawimg);

%% Padding zeros.
padH=mod(8-M,8);padW=mod(8-N,8);
padU=ceil(padH/2);
padL=ceil(padW/2);
imgdata=zeros(M+padH,N+padW);
imgdata(padU+1:padU+M,padL+1:padL+N)=double(rawimg);

%% Calculation.
blockRow=(M+padH)/8;blockCol=(N+padW)/8;
if strcmp(maskType,'Zonal')
    mask=[1,1,1,1,1,0,0,0;
        1,1,1,1,0,0,0,0;
        1,1,1,0,0,0,0,0;
        1,1,0,0,0,0,0,0;
        1,0,0,0,0,0,0,0;
        0,0,0,0,0,0,0,0;
        0,0,0,0,0,0,0,0;
        0,0,0,0,0,0,0,0];
    for k=1:blockRow
        for m=1:blockCol
            blockX=k*8-7:k*8;
            blockY=m*8-7:m*8;
            imgdata(blockX,blockY)=dip2DDCT(imgdata(blockX,blockY));
            imgdata(blockX,blockY)=imgdata(blockX,blockY).*mask;
            imgdata(blockX,blockY)=dip2DIDCT(imgdata(blockX,blockY));
        end
    end
elseif strcmp(maskType,'Threshold')
    Z=[16,11,10,16,24,40,51,61;
        12,12,14,19,26,58,60,55;
        14,13,16,24,40,57,69,56;
        14,17,22,29,51,87,80,62;
        18,22,37,56,68,109,103,77;
        24,35,55,64,81,104,113,92;
        49,64,78,87,103,121,120,101;
        72,92,95,98,112,100,103,99]*Ztimes;
    for k=1:blockRow
        for m=1:blockCol
            blockX=k*8-7:k*8;
            blockY=m*8-7:m*8;
            imgdata(blockX,blockY)=dip2DDCT(imgdata(blockX,blockY));
            imgdata(blockX,blockY)=round(imgdata(blockX,blockY)./Z).*Z;
            imgdata(blockX,blockY)=dip2DIDCT(imgdata(blockX,blockY));
        end
    end
end
resData=imgdata(padU+1:padU+M,padL+1:padL+N);

end

