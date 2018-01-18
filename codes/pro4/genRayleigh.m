function [ noiseMat ] = genRayleigh( varargin )
%GENRAYLEIGH Generate rayleigh distributed noise data.
%   noiseMat = GENRAYLEIGH(M,N,a,b) will return a MxN noise matrix with
%   rayleigh distribution. Formally, they sample values for a R.V. z which 
%   has a PDF as follows:
%           p(z)=2/b*(z-a)*exp(-(z-a)^2/b),z>=a;    0,z<a;
%   a,b are respectively 0 and 1 by default.

if nargin<2||nargin>4
    error('Wrong parameters!');
end
M=varargin{1};N=varargin{2};
a=0;b=1;
if nargin>=3
    a=varargin{3};
end
if nargin>=4
    b=varargin{4};
end

U=genUniform(M,N);
noiseMat=a+sqrt(-b*log(1-U));

end

