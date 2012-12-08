%%
%
%
function modelParameters = trainContinuousEstimator_simplekal(training_data, order, bin_size, selected_neurons)

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

A = cell(n_angles, 2);
W = A;
HQ = cell(n_angles, 2);

% size(state) = 2 * (order + 1);
% state_data = 2-D structure
% state_data(trials, angles).state = matrix (2 * (order + 1)) x (number of bins + 1)
% n_bin_max = % max index of bin for each trial and each angle : matrix
% trials x angle
[state_activity, states_0] = extract_state_and_activity_data(training_data, bin_size, order, selected_neurons);


for i_angle = 1:n_angles
    
    [A{i_angle} W{i_angle}] = train_traj_simple(training_data);
    state_data_angle = state_activity(:, i_angle);
    HQ(i_angle,1:2) = observation_parameters_kalman(state_data_angle);
    
end

modelParameters = struct('A', A, 'W', W, 'H', HQ(:,1), 'Q', HQ(:,2),...
                         'method', 'simple_kal', 'order', order, 'bin_size', bin_size,...
                         'selected_neurons', selected_neurons, 'states_0', states_0);

end
%%
%
%