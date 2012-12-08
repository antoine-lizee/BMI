%%
%
%
function [x, y, modelParameters] = positionEstimator_simplekal(test_data, modelParameters)

order = modelParameters(1).order;
traj_angle = modelParameters(1).angle;

% Initialisation
if modelParameters(1).isFirst
    [modelParameters.isFirst] = deal(0);
    [modelParameters.P] = deal(zeros(2 * (order + 1)));
    
    state_0 = mean(modelParameters(traj_angle).states_0, 2);
    state_0(1:2) = test_data.startHandPos;
    [modelParameters.state] = deal(state_0);
    
end

order = modelParameters(1).order;

bin_size = modelParameters(1).bin_size;
selected_neurons = modelParameters(1).selected_neurons;

%             test_data.spikes = 98x120 matrix of spiking activity
last_point = size(test_data.spikes, 2);
activity = sum(test_data.spikes(selected_neurons, (last_point - bin_size + 1):last_point), 2) / bin_size;

previous_state = modelParameters(1).state;

A = modelParameters(traj_angle).A;
W = modelParameters(traj_angle).W;
H = modelParameters(traj_angle).H;
Q = modelParameters(traj_angle).Q;
P_previous = modelParameters(traj_angle).P;

new_state_m = A * previous_state;
P_m = A  * P_previous * A' + W;
K = P_m * H'  / (H * P_m  * H' + Q);

new_state = new_state_m + K * (activity - H * new_state_m);

% update
P = (eye(2*(order+1)) - K * H) * P_m;
[modelParameters.P] = deal(P);
[modelParameters.state] = deal(new_state);
x = new_state(1);
y = new_state(2);

end
%%
%
%