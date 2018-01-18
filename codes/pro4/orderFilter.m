function [ resdata ] = orderFilter(  imagedata, filterType, m, n, d )
%ORDERFILTER Compute the result of filtering with a order statistics filter
%specified by the second parameter.
%   resdata=ORDERFILTER(imagedata,filterType,m,n,d) will return the
%   filtering result. The filterType can be specified as one of these
%   values:
%           'median','max','min','midpoint','alphamean'
%   m and n should be positive and odd integers. If filterType is 
%   'alphamean', you should specify d. And only in this case, d will be
%   used. d should be even and in the interval [0,mn-1].

%% Initialize parameters.
if mod(m,2)==0 || mod(n,2)==0 || m<=0 || n<=0
    error('m and n should be positive and odd integers!');
end
if strcmp(filterType,'alphamean')
    if nargin<5
        error('You should specify d!');
    elseif d<0||d>=m*n||mod(d,2)==1
        error('d should be an even integer between 0 and mn-1.');
    end
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
            case 'median'
                resdata(k,s)=median(neighbor(:));
            case 'max'
                resdata(k,s)=max(max(neighbor));
            case 'min'
                resdata(k,s)=min(min(neighbor));
            case 'midpoint'
                neighbor=neighbor(:);
                resdata(k,s)=0.5*(min(neighbor)+max(neighbor));
            case 'alphamean'
                neighbor=sort(neighbor(:));
                resdata(k,s)=1/(m*n-d)*sum(neighbor(d/2+1:end-d/2));
            otherwise
                error('Unknown filter type!');
        end
    end
end

end

