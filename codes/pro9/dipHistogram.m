function [ freq, intensity] = dipHistogram( imgdata, bitnum )

%% Handle the parameters.
if nargin<1||nargin>2
    error('Wrong parameters!');
end
if nargin<2
    bitnum=8;
end

%% Compute the histogram.
graylevel=2^bitnum;
img=double(imgdata);
intensity=0:graylevel-1;
freq=zeros(1,graylevel);
for k=1:numel(img)
    freq(img(k)+1)=freq(img(k)+1)+1;
end

end