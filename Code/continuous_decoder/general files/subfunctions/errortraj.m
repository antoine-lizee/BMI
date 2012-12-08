function [ e E ] = errortraj( traj_test,traj_giv )
%ERRORTRAJ Summary of this function goes here
%   Detailed explanation goes here

if size(traj_test)~=size(traj_giv)
    error('Trajectories are not formatted the same way, impossible to compute the error');
end

if isnumeric(traj_test)
    E=sqrt(sum((traj_test-traj_giv).^2,1));
    e=mean(E);
    return;
end

n_t=numel(traj_test);
E=cell(n_t,1);
e=zeros(1,n_t);
for i_t=1:n_t
    E{i_t}=sqrt(sum((traj_test{i_t}-traj_giv{i_t}).^2,1));
    e(i_t)=mean(E{i_t});
end    

end

