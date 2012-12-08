%%
%
%
function [x, y, modelParameters] = positionEstimator_kalman(test_data, modelParameters)

order = modelParameters(1).order;
traj_angle = modelParameters(1).angle;

% Initialisation
if modelParameters(traj_angle).step == 0
    
    modelParameters(traj_angle).P = zeros(2 * (order + 1));
    
    state_0 = mean(modelParameters(traj_angle).states_0, 2);

    state_0(1:2) = test_data.startHandPos;
    modelParameters(traj_angle).state = state_0;
    
end

modelParameters(traj_angle).step = modelParameters(traj_angle).step + 1;

bin_size = modelParameters(1).bin_size;
selected_neurons = modelParameters(traj_angle).selected_neurons;

% test_data.spikes = 98x120 matrix of spiking activity

M_x = modelParameters(traj_angle).M_x;
M_z = modelParameters(traj_angle).M_z;

last_point = size(test_data.spikes, 2);
activity = sum(test_data.spikes(selected_neurons, (last_point - bin_size + 1):last_point), 2) / bin_size;
z_c = activity - M_z;

previous_state = modelParameters(traj_angle).state; % - M_x;

A = modelParameters(traj_angle).A;
W = modelParameters(traj_angle).W;
H = modelParameters(traj_angle).H;
Q = modelParameters(traj_angle).Q;
P_previous = modelParameters(traj_angle).P;

new_state_m = A * previous_state;
P_m = A  * P_previous * A' + W;
K = P_m * H'  / (H * P_m  * H' + Q);

new_state = new_state_m + K * (z_c - H * (new_state_m - M_x)); % + M_x;

% update
P = (eye(2*(order+1)) - K * H) * P_m;
modelParameters(traj_angle).P = P;
modelParameters(traj_angle).state = new_state;

x = new_state(1);
y = new_state(2);

end
%%
%
%