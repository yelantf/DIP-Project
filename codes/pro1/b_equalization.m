function [ enhancedImg, transFuncy, transFuncx ] = b_equalization( varargin )
%B_EQUALIZATION Enhance an image by using histogram equalization technique.
% [enhancedImg, transFunc] = B_EQUALIZATION( RAWIMG, BITNUM, PLOTFLAG) will
% return the enhanced image data as uint16 type and its transformation
% function in two vectors transFuncy and transFuncx. You can plot it with
% 'PLOT(transFuncx, transFuncy)'. RAWIMG is the raw image data and other
% parameters are optional. BITNUM is 8 by default which specifies the
% gray level with 2^BITNUM, and PLOTFLAG is set to be true , if you donnot
% want to plot the process of whole improvement, please set it to be false.

%% Handle the parameters.
[rawimg, bitnum, plotflag]=handleparas(varargin{:});

%% Enhance the image.
[freq, intensity]=a_histogram(rawimg,bitnum,false);
graylevel=2^bitnum;
transFuncx=0:graylevel-1;
transFuncy=uint16(zeros(1,graylevel));
prosum=0;
pros=freq/numel(rawimg);
for k=1:graylevel
    prosum=prosum+pros(k);
    transFuncy(k)=uint16((graylevel-1)*prosum);
end
enhancedImg=transFuncy(double(rawimg)+1);

%% Plot the enhancement.
if plotflag
    subplot(2,2,1);
    imshow(rawimg,[0 graylevel-1]);
    title('original image');
    subplot(2,2,2);
    plotbar(intensity,freq,bitnum);
    title('histogram of the original image');
    subplot(2,2,3);
    imshow(enhancedImg,[0 graylevel-1]);
    title('enhanced image');
    subplot(2,2,4);
    [freq, intensity]=a_histogram(enhancedImg,bitnum,false);
    plotbar(intensity,freq,bitnum);
    title('histogram of the enhanced image');
end

end