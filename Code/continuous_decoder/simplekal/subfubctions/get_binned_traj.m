function [ out_traj ] = get_binned_traj( in_traj, bin_size )
%GET_BINNED_TRAJ Summary of this function goes here
%   Detailed explanation goes here


if isnumeric(in_traj)
    out_traj=in_traj(:,300:bin_size:end);
    return
end

n_t=numel(in_traj);
out_traj=cell(n_t,1);
for i_t=1:n_t
    out_traj{i_t}=in_traj{i_t}(1:2,300:bin_size:end);
end
    
end

