function tmp=showSpectrum( spec )
%SHOWSPECTRUM Show the spectrum in a proper way.

spec=double(spec);
spec=log10(1+spec);
minval=min(spec(:));maxval=max(spec(:));
spec=(spec-minval)*255/(maxval-minval);
imshow(uint8(spec));
tmp=spec;

end

