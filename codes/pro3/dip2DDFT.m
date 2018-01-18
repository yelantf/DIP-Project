function [ Fmat ] = dip2DDFT( fmat )
%DIP2DDFT Calculate the 2-D DFT of a function.
%   Fmat=DIP2DDFT(fmat) will return the DFT result of the matrix fmat.

fmat=double(fmat);
[M,N]=size(fmat);
x=0:M-1;y=0:N-1;
[x,u]=meshgrid(x,x);
[v,y]=meshgrid(y,y);

premat=exp(-1i*2*pi/M);
premat=premat.^(u.*x);

postmat=exp(-1i*2*pi/N);
postmat=postmat.^(v.*y);

Fmat=premat*fmat*postmat;

end