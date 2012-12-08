%%
%
% equally spaced bins
%
% size(state) = 2 * (order + 1);
% data = 2-D structure
% data(trials, angles).state = matrix (2 * (order + 1)) x (number of bins)
% n_bin_max = % max index of bin for each trial and each angle : matrix
% trials x angle
%
function [data, state_0] = extract_state_and_activity_data(training_data, bin_size, order, selected_neurons)
%
% training data contains all the data sampled at 1ms until end of movement
% + 100ms
% movement starts at 300ms
%
% need to extract kinematics data during the movement for each bin, ie
% indexes :
% 300
% 301                   to  300 + bin_size
% 301 + bin_size        to	300 + 2 * bin_size
% 301 + 2 * bin_size    to	300 + 3 * bin_size
% ...
%
if nargin < 4
    selected_neurons = 1:98;
end

if nargin < 3
    order = 2;
end

if nargin < 2
    bin_size = 20;
end

n_trials = size(training_data, 1);
n_angles = size(training_data, 2);

celleg = cell(n_trials, n_angles);
data = struct('state', celleg);

state_0 = cell(n_angles, 1);


for i_a = 1:n_angles
    
    temp = zeros(2*(order+1), n_trials);
    
    for i_t = 1:n_trials
        
        data(i_t, i_a).state = compute_state(training_data, bin_size, i_t, i_a, order);
        temp(:,i_t) = data(i_t, i_a).state(:,1);
        
        data(i_t, i_a).activity = compute_activity(training_data, bin_size, i_t, i_a, order, selected_neurons);
        
    end
    state_0{i_a} = temp;
end


end
%%
%
%