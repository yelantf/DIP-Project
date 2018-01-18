function [resImg,gridInds,connectImg] = dipResample(boundInds,gridScale,sz)
%DIPRESAMPLE 此处显示有关此函数的摘要
%   此处显示详细说明

%% Subsampled boundary.
gridSZ=ceil((sz+gridScale)/(gridScale+1));
rows=1:gridSZ(1);
rows=(rows-1)*(gridScale+1)+1;
cols=1:gridSZ(2);
cols=(cols-1)*(gridScale+1)+1;

t1=floor(gridScale/2);t2=gridScale-t1;
[Ymat,Xmat]=meshgrid(cols,rows);
rawInds=[];
for k=1:size(boundInds,1)
    [gridX,gridY]=find(Xmat+t1>=boundInds(k,1)&Xmat-t2<boundInds(k,1)&...
        Ymat+t1>=boundInds(k,2)&Ymat-t2<boundInds(k,2),1);
    rawInds=[rawInds;rows(gridX),cols(gridY)];
end
rawInds=unique(rawInds,'rows','stable');
mask=rawInds(:,1)<=sz(1)&rawInds(:,2)<=sz(2);

resImg=false(sz);
drawInds=rawInds(mask,:);
resImg(sub2ind(sz,drawInds(:,1),drawInds(:,2)))=true;

gridInds=(rawInds-1)/(gridScale+1)+1;

%% Connect points.
drawInds=rawInds;
if drawInds(end,1)~=drawInds(1,1)||drawInds(end,2)~=drawInds(1,2)
    drawInds(end+1,:)=drawInds(1,:);
end
lineInds=[];
for k=2:size(drawInds,1)
    newInds=lineconn(drawInds(k,:),drawInds(k-1,:));
    lineInds=[lineInds;newInds];
end

mask=lineInds(:,1)<=sz(1)&lineInds(:,2)<=sz(2);
lineInds=lineInds(mask,:);
connectImg=false(sz);
connectImg(sub2ind(sz,lineInds(:,1),lineInds(:,2)))=true;

end

function lineInds=lineconn(dot1,dot2)
x1=dot1(1);y1=dot1(2);
x2=dot2(1);y2=dot2(2);
dx=x2-x1;dy=y2-y1;
if dx==0&&dy==0
    lineInds=dot1;
    return;
end
if(abs(dx)>=abs(dy))
    k=dy/dx;
    if x1>x2
        x=(x2:x1)';
    else
        x=(x1:x2)';
    end
    y=round(y1+k*(x-x1));
else
    k_=dx/dy;
    if y1>y2
        y=(y2:y1)';
    else
        y=(y1:y2)';
    end
    x=round(x1+k_*(y-y1));
end
lineInds=[x,y];
end
