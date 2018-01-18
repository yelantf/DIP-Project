function [ freq, intensity ] = my_hist( varargin )
%MY_HIST This function is only used to show the histogram of an image after
%adding noise to it. The histogram will allow nagative intensity values and
%intensity values larger than graylevel for better shape of distribution.
%   [freq, intensity] = MY_HIST(data, bitnum ,plotflag) will return the 
%   frequency of different intensity values and corresponding intensity 
%   values. If plotflag is true, it will plot the hist by with function 
%   plotHist.

[data,bitnum,plotflag]=handleparas(varargin{:});

tmpdata=double(data(:));
minval=min(tmpdata);maxval=max(tmpdata);
intensity=minval:maxval;
freq=zeros(1,length(intensity));

for k=1:numel(tmpdata)
    intens=round(tmpdata(k)-minval)+1;
    freq(intens)=freq(intens)+1;
end

if plotflag
    plotHist(freq, intensity,bitnum);
end

end

