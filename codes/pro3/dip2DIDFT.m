function [ fmat ] = dip2DIDFT( Fmat )
%DIP2DIDFT Calculate the 2-D IDFT of a function.
%    fmat=DIP2DIDFT(Fmat) will return the IDFT result of the matrix Fmat.

MN=numel(Fmat);
fmat=conj(dip2DDFT(conj(Fmat)))/MN;

end