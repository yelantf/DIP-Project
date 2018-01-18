function plotHist( freq, intensity,bitnum )
%PLOTHIST Plot the hist in a proper way.

graylevel=2^bitnum;
bar(intensity,freq);
xlim([intensity(1)-1 intensity(end)+1]);
if bitnum<=3
    xtick=0:1:graylevel-1;
else
    xtick=[0:graylevel/8:graylevel-1 graylevel-1];
end
if intensity(1)<0
    xtick=[intensity(1) xtick];
end
if intensity(end)>graylevel-1
    xtick=[xtick intensity(end)];
end
set(gca,'XTick',xtick);
xlabel('intensity');
ylabel('frequency');

end

