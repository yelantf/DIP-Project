function plotbar( intensity,freq,bitnum )
%PLOTBAR Plot bar graph in a proper way.

if nargin<2||nargin>3
    error('Wrong parameters!');
end
if nargin<3
    bitnum=8;
end

graylevel=2^bitnum;
bar(intensity,freq);
xlim([-1 graylevel]);
if bitnum<=3
    set(gca,'XTick',0:1:graylevel-1);
else
    set(gca,'XTick',[0:graylevel/8:graylevel-1 graylevel-1]);
end
xlabel('intensity');
ylabel('frequency');
end

