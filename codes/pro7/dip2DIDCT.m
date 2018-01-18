function [gmat] = dip2DIDCT(Tmat)
%DIP2DIDCT Calculate the 2-D IDCT of a function.
%   gmat=DIP2DIDCT(Tmat) will return the IDCT result of the matrix Tmat.

Tmat=double(Tmat);
[M,N]=size(Tmat);
u=0:M-1;v=0:N-1;
[u,x]=meshgrid(u,u);
[y,v]=meshgrid(v,v);

premat=ones(M,M)*sqrt(2/M);
premat(:,1)=sqrt(1/M);
premat=premat.*cos((2*x+1).*u*pi/(2*M));

postmat=ones(N,N)*sqrt(2/N);
postmat(1,:)=sqrt(1/N);
postmat=postmat.*cos((2*y+1).*v*pi/(2*N));

gmat=premat*Tmat*postmat;

end

