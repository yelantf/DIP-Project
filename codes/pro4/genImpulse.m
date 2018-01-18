function [ noiseMat ] = genImpulse( varargin )
%GENIMPULSE Generate impulse distributed noise data.
%   noiseMat = GENIMPULSE(M,N,a,b) will return a MxN noise matrix with
%   impulse distribution. Formally, they sample values for a R.V. z 
%   which has a PDF as follows:
%           p(z)=a,z=0; b,z=1;  0,otherwise;
%   a and b are both 0.1 by default.

if nargin<2||nargin>4
    error('Wrong parameters!');
end
M=varargin{1};N=varargin{2};
a=0.1;b=0.1;
if nargin>=3
    a=varargin{3};
end
if nargin>=4
    b=varargin{4};
end

noiseMat=ones(M,N)*0.5;
U=rand(M,N);
noiseMat(U<=a)=0;
noiseMat(U>=1-b)=1;

end

