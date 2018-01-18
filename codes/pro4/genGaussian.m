function [ noiseMat ] = genGaussian( varargin )
%GENGAUSSIAN Generate uniform distributed noise data.
%   noiseMat = GENGAUSSIAN(M,N,a,b) will return a MxN noise matrix with
%   gaussian distribution. Formally, they sample values for a R.V. z which 
%   has a PDF as follows:
%           p(z)=1/(sqrt(2*pi)*b)*exp(-(z-a)^2/(2*b^2))
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

%{
u1=genUniform(M,N);u2=genUniform(M,N);
noiseMat=a+b*sqrt(-2*log(u1))*cos(2*pi*u2);
%}

U=genUniform(M,N);
noiseMat=a+b*sqrt(2)*erfinv(2*U-1);

end

