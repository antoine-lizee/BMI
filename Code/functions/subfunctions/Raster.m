function [h R] = Raster( X, dt)
%RASTER subfunction for Raster plotting.
%   Detailed explanation goes here

if nargin < 2
    dt=1;
end

T=size(X,2);
N=size(X,1);
R=(linspace(1,255,N)'*ones(1,T)).*X;

%h=axes('Parent', fig);
h=imagesc(R);
%axis image
map=lines(256);
map(1,:)=ones(1,3);
map(2:end,:)=0; % all blacks
colormap(map);


end

