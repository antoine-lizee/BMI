%%
%
%
function modelParameters = trainContinuousEstimator_kalman(training_data, order, bin_size, selected_neurons)

if nargin < 4
    selected_neurons = 1:98;
end

if nargin < 3
    bin_size = 20;
end

if nargin < 2
    order = 2;
end

n_angles = size(training_data, 2);

A = cell(n_angles, 1);
W = cell(n_angles, 1);

MX_p = cell(n_angles, 1);
MX_f = cell(n_angles, 1);

H = cell(n_angles, 1);
Q = cell(n_angles, 1);

M_z = cell(n_angles, 1);
M_x = cell(n_angles, 1);

% size(state) = 2 * (order + 1);
% state_data = 2-D structure
% state_data(trials, angles).state = matrix (2 * (order + 1)) x (number of bins + 1)
% n_bin_max = % max index of bin for each trial and each angle : matrix
% trials x angle
[state_activity, states_0] = extract_state_and_activity_data(training_data, bin_size, order, selected_neurons);


for i_angle = 1:n_angles
    
    state_data_angle = state_activity(:, i_angle);
    [A{i_angle}, W{i_angle}, MX_p{i_angle}, MX_f{i_angle}] = trajectory_parameters_kalman(state_data_angle);
    [H{i_angle}, Q{i_angle}, M_z{i_angle}, M_x{i_angle}] = observation_parameters_kalman(state_data_angle);
    
end


modelParameters = struct('A', A, 'W', W, 'H', H, 'Q', Q,...
                         'MX_p', MX_p, 'MX_f', MX_f, ...
                         'M_z', M_z, 'M_x', M_x, 'method', 'kalman',...
                         'order', order, 'bin_size', bin_size,...
                         'selected_neurons', selected_neurons, 'states_0', states_0,...
                         'step', 0);

end
%%
%
%