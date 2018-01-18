function [ noiseMat ] = genUniform( varargin )
%GENUNIFORM Generate uniform distributed noise data.
%   noiseMat = GENUNIFORM(M,N,a,b) will return a MxN noise matrix with
%   uniform distribution. Formally, they sample values for a R.V. z which 
%   has a PDF as follows:
%           p(z)=1/(b-a),a<=z<=b;   0,otherwise.
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

noiseMat=a+(b-a)*rand(M,N);

end

