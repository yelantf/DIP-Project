function [ resdata ] = meanFilter( imagedata, filterType, m, n, Q)
%MEANFILTER Compute the result of filtering with a mean filter specified by
% the second parameter.
%   resdata=MEANFILTER(imagedata,filterType,m,n,Q) will return the
%   filtering result. The filterType can be specified as one of these
%   values:
%       'arithmetic','geometric','harmonic','contraharmonic'
%   m and n should be positive and odd integers. If filterType is
%   'contraharmonic', you should specify Q. And only in this case, Q will 
%   be used.

%% Initialize parameters.
if strcmp(filterType,'contraharmonic')&&nargin<5
    error('You should specify Q!');
end
if mod(m,2)==0 || mod(n,2)==0 || m<=0 || n<=0
    error('m and n should be positive and odd integers!');
end

%% Padding zeros.
imgsize=size(imagedata);
filtersize=[m,n];
padnum=(filtersize-1)/2;
img=zeros(imgsize+padnum*2);
img(padnum(1)+1:end-padnum(1),padnum(2)+1:end-padnum(2))=double(imagedata);
resdata=zeros(imgsize);

%% Do filtering.
for k=1:imgsize(1)
    for s=1:imgsize(2)
        neighbor=img(k:k+m-1,s:s+n-1);
        switch filterType
            case 'arithmetic'
                resdata(k,s)=sum(sum(neighbor))/(m*n);
            case 'geometric'
                resdata(k,s)=prod(prod(neighbor)).^(1/(m*n));
            case 'harmonic'
                invfrac=1./neighbor;
                resdata(k,s)=m*n/sum(sum(invfrac));
            case 'contraharmonic'
                power_q=neighbor.^Q;
                power_qp1=neighbor.*power_q;
                resdata(k,s)=sum(sum(power_qp1))/sum(sum(power_q));
            otherwise
                error('Unknown filter type!');
        end
    end
end

end

