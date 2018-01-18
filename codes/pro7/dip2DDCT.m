function [Tmat] = dip2DDCT(gmat)
%DIP2DDCT Calculate the 2-D DCT of a function.
%   Tmat=DIP2DDCT(gmat) will return the DCT result of the matrix gmat.

gmat=double(gmat);
[M,N]=size(gmat);
x=0:M-1;y=0:N-1;
[x,u]=meshgrid(x,x);
[v,y]=meshgrid(y,y);

premat=ones(M,M)*sqrt(2/M);
premat(1,:)=sqrt(1/M);
premat=premat.*cos((2*x+1).*u*pi/(2*M));

postmat=ones(N,N)*sqrt(2/N);
postmat(:,1)=sqrt(1/N);
postmat=postmat.*cos((2*y+1).*v*pi/(2*N));

Tmat=premat*gmat*postmat;

end

