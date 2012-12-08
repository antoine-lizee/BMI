function [ traj_test ] = trajectoriesEstimator( data, param, method )
%TRAJECTORYESTIMATOR Summary of this function goes here
%   Detailed explanation goes here

n_test=numel(data);
traj_test=cell(n_test,1);

for i_test=1:n_test
    test_data=data(i_test);
    T_init=300;
    n_T=size(data(i_test).spikes,2)-T_init; %time span for each trial
    l_step=20;
    n_step=floor(n_T/l_step);
    test_data.startHandPos=test_data.handPos(1:2,T_init);
    traj=test_data.startHandPos;    
    modelParameters=param;
    [modelParameters.angle]=deal(i_test);
    for i_step=1:n_step
        test_data_i=test_data;
        test_data_i.spikes(:,[1:199 (T_init+(i_step*l_step)+1):end])=[];
        test_data_i.decodedHandPos=traj;
        [x, y, modelParameters]=positionEstimator( test_data, modelParameters);
        traj=[traj, [x;y]]; %#ok<AGROW>
    end
    traj_test{i_test}=traj;
end


end

