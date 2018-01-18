function [ noiseMat ] = genExponential( varargin )
%GENEXPONENTIAL Generate exponential distributed noise data.
%   noiseMat = GENEXPONENTIAL(M,N,a) will return a MxN noise matrix with
%   exponential distribution. Formally, they sample values for a R.V. z 
%   which has a PDF as follows:
%           p(z)=a*exp(-a*z),z>=0;  0,z<0.
%   a is 1 by default and a should be positive.

if nargin<2||nargin>3
    error('Wrong parameters!');
end
M=varargin{1};N=varargin{2};
a=1;
if nargin>=3
    a=varargin{3};
end

U=genUniform(M,N);
noiseMat=-1/a*log(1-U);

end

