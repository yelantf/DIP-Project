function [c,s] = dip2DFWT(f,n,wavetype)
%DIP2DFWT 此处显示有关此函数的摘要
%   此处显示详细说明

%% Initialize data.
[h0,h1]=getFilter(wavetype);
hLen=length(h0);sz=size(f);
c = [];s = sz;fdb=double(f);

%% Do the iteration.
for k=1:n
    newsz=floor((hLen+sz-1)/2);
    fdb=padarray(fdb,[hLen-1 hLen-1],'symmetric','both');
    
    rows=conv2(fdb,h1);
    rows=rows(:,1:2:end);
    rows=rows(:,hLen/2+1:newsz(2)+hLen/2);
    coefs=conv2(rows,h1');
    coefs=coefs(1:2:end,:);
    coefs=coefs(hLen/2+1:newsz(1)+hLen/2,:);
    c=[coefs(:)' c]; s=[newsz;s];
    coefs=conv2(rows,h0');
    coefs=coefs(1:2:end,:);
    coefs=coefs(hLen/2+1:newsz(1)+hLen/2,:);
    c=[coefs(:)' c];
    
    rows=conv2(fdb,h0);
    rows=rows(:,1:2:end);
    rows=rows(:,hLen/2+1:newsz(2)+hLen/2);
    coefs=conv2(rows,h1');
    coefs=coefs(1:2:end,:);
    coefs=coefs(hLen/2+1:newsz(1)+hLen/2,:);
    c=[coefs(:)' c];
    coefs=conv2(rows,h0');
    coefs=coefs(1:2:end,:);
    fdb=coefs(hLen/2+1:newsz(1)+hLen/2,:);
    sz=size(fdb);
end
c=[fdb(:)' c]; s=[sz;s];
    
end

%% Get filters.
function [h0,h1]=getFilter(waveType)
switch lower(waveType)
    case 'haar'
        h0=[1 1]/sqrt(2);
        h1=[-1 1]/sqrt(2);
    case 'daubechies'
        g0=[0.23037781,0.71484657,0.63088076,-0.02798376,...
            -0.18703481,0.03084138,0.03288301,-0.01059740];
        h0=g0(end:-1:1);g1=(-1).^(0:7).*h0;h1=g1(end:-1:1);
    case 'symlet'
        g0=[0.0322,-0.0126,-0.0992,0.2979,...
            0.8037,0.4976,-0.0296,-0.0758];
        h0=g0(end:-1:1);g1=(-1).^(0:7).*h0;h1=g1(end:-1:1);
    case 'cdf'
        h0=[0,0.0019,-0.0019,-0.017,0.0119,0.0497,-0.0773,-0.0941,0.4208,...
            0.8259,0.4208,-0.0941,-0.0773,0.0497,0.0119,-0.017,-0.0019,0.0010];
        h1=[0,0,0,0.0144,-0.0145,-0.0787,0.0404,0.4178,-0.7589,...
            0.4178,0.0404,-0.0787,-0.0145,0.0144,0,0,0,0];
    otherwise
        error('Unrecognizable wavelet type name (wavetype).');
end
end