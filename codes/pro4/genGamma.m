function [ noiseMat ] = genGamma( varargin )
%GENGAMMA Generate gamma distributed noise for an image.
%   noiseMat = GENGAMMA(M,N,a,b) will return a MxN noise matrix with
%   gamma distribution. Formally, they sample values for a R.V. z which 
%   has a PDF as follows:
%           p(z)=a^b*z^(b-1)/factorial(b-1)*exp(-a*z),z>=a; 0,z<a;
%   a,b are respectively 1 and 3 by default. Gamma distribution can be
%   regarded as the sum of b independent exponential variables with mean
%   1/a each. a should be positive and b should be a positive integer.

if nargin<2||nargin>4
    error('Wrong parameters!');
end
M=varargin{1};N=varargin{2};
a=1;b=3;
if nargin>=3
    a=varargin{3};
end
if nargin>=4
    b=varargin{4};
end

%{
noiseMat=zeros(M,N);
for k=1:b
    noiseMat=noiseMat+genExponential(M,N,a);
end
%}

%For efficiency, we use this implementation, it is equal to commented block
%functionally.
    
U=ones(M,N);
for k=1:b
    U=U.*genUniform(M,N);
end
noiseMat=-log(U)/a;

end

