function [ states ] = get_state( xy, bin_size, order )
%GET_STATE Summary of this function goes here
%   Detailed explanation goes here

if nargin<3
    order=2;
end

if isnumeric(xy)
    n_bins=size(xy,2);
    states=zeros((order+1)*2,n_bins);
    states(1:2,:)=xy(:,1:end);
    for i_o=1:order;
        % d^(i_o)x / dt^(i_o)
        states(2 * i_o + 1, 2:end) = diff(states(2 * (i_o - 1) + 1, 1:end)) / bin_size;
        % d^(i_o)y / dt^(i_o)
        states(2 * i_o + 2, 2:end) = diff(states(2 * (i_o - 1) + 2, 1:end)) / bin_size;
    end
    states(:,n_bins+1:end)=[];
    return;
end

n_t=numel(xy);
states=cell(n_t,1);
for i_t=1:n_t
    states{i_t}=get_state( xy{i_t}, bin_size, order );
end

end

