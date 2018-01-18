function [f] = dip2DIFWT(c,s,wavetype)
%DIP2DIFWT 此处显示有关此函数的摘要
%   此处显示详细说明

%% Initialize data.
[g0,g1]=getFilter(wavetype);
gLen=length(g0);
eleNum=prod(s,2);
f=reshape(c(1:eleNum(1)),s(1,:));

N=numel(eleNum)-2;
rInd=eleNum(1);
for k=2:N+1
    lInd=rInd+1;rInd=rInd+3*eleNum(k);
    hvd=c(lInd:rInd);
    h=reshape(hvd(1:eleNum(k)),s(k,:));
    v=reshape(hvd(eleNum(k)+1:2*eleNum(k)),s(k,:));
    d=reshape(hvd(2*eleNum(k)+1:3*eleNum(k)),s(k,:));
    
    drowx2=zeros(s(k,1)*2,s(k,2));drowx2(2:2:end,:)=d;
    drowx2=conv2(drowx2,g1');
    vrowx2=zeros(s(k,1)*2,s(k,2));vrowx2(2:2:end,:)=v;
    vrowx2=conv2(vrowx2,g0');
    dv=drowx2+vrowx2;
    dvx2=zeros([1 2].*size(dv));dvx2(:,2:2:end)=dv;
    dvx2=conv2(dvx2,g1);
    dvx2=dvx2(gLen:gLen+s(k+1,1)-1,gLen:gLen+s(k+1,2)-1);
    
    hrowx2=zeros(s(k,1)*2,s(k,2));hrowx2(2:2:end,:)=h;
    hrowx2=conv2(hrowx2,g1');
    frowx2=zeros(s(k,1)*2,s(k,2));frowx2(2:2:end,:)=f;
    frowx2=conv2(frowx2,g0');
    hf=hrowx2+frowx2;
    hfx2=zeros([1 2].*size(hf));hfx2(:,2:2:end)=hf;
    hfx2=conv2(hfx2,g0);
    hfx2=hfx2(gLen:gLen+s(k+1,1)-1,gLen:gLen+s(k+1,2)-1);
    
    f=dvx2+hfx2;
end

end

%% Get filters.
function [g0,g1]=getFilter(waveType)
switch lower(waveType)
    case 'haar'
        g0=[1 1]/sqrt(2);
        g1=[1 -1]/sqrt(2);
    case 'daubechies'
        g0=[0.23037781,0.71484657,0.63088076,-0.02798376,...
            -0.18703481,0.03084138,0.03288301,-0.01059740];
        h0=g0(end:-1:1);g1=(-1).^(0:7).*h0;
    case 'symlet'
        g0=[0.0322,-0.0126,-0.0992,0.2979,...
            0.8037,0.4976,-0.0296,-0.0758];
        h0=g0(end:-1:1);g1=(-1).^(0:7).*h0;
    case 'cdf'
        h0=[0,0.0019,-0.0019,-0.017,0.0119,0.0497,-0.0773,-0.0941,0.4208,...
            0.8259,0.4208,-0.0941,-0.0773,0.0497,0.0119,-0.017,-0.0019,0.0010];
        h1=[0,0,0,0.0144,-0.0145,-0.0787,0.0404,0.4178,-0.7589,...
            0.4178,0.0404,-0.0787,-0.0145,0.0144,0,0,0,0];
        g0=(-1).^(1:18).*h1;g1=(-1).^(0:17).*h0;
    otherwise
        error('Unrecognizable wavelet type name (wavetype).');
end
end