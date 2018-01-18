function [ freq, intensity] = a_histogram( varargin )
%A_HISTOGRAM This function compute the histogram of an image.
% [freq, intensity] = A_HISTOGRAM( IMAGEDATA, BITNUM, PLOTFLAG ) will plot the
% histogram of image data which saved in variable IMAGEDATA. BITNUM is
% optional and used to specified our target graylevel as 2^BITNUM, which is
% 8 by default. The PLOTFLAG should be true if you want to plot the
% histogram, false otherwise. true is set by default. This function will 
% finally return two vectors, which are frequency and intensity.

%% Handle the parameters.
[imgdata, bitnum, plotflag]=handleparas(varargin{:});

%% Compute the histogram.
graylevel=2^bitnum;
img=double(imgdata);
intensity=0:graylevel-1;
freq=zeros(1,graylevel);
for k=1:numel(img)
    freq(img(k)+1)=freq(img(k)+1)+1;
end

%% Try to plot the histogram.
if plotflag
    plotbar(intensity,freq,bitnum);
end

end