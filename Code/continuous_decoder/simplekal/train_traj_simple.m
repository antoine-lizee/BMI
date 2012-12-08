function [A, W] = train_traj_simple( trial)
%TRAIN_TRAJ_SIMPLE Summary of this function goes here
%   Detailed explanation goes here

bin_size=20;
order=2;
xy=get_binned_traj({trial.handPos},bin_size); %cell array with binned trajectories in each cell
states=get_state(xy,bin_size,order); %cell array with

for i_t=1:numel(xy)
    xy{i_t}=xy{i_t}(:,2:end);
    states{i_t}=states{i_t}(:,1:end-1);
end

xy_tot=[xy{:}]';
states_tot=[states{:}]';
A=states_tot\xy_tot;
W=std(xy_tot,1);

end

