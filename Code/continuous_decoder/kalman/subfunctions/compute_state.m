%%
%
%
function state = compute_state(training_data, bin_size, i_t, i_a, order)

% size(state) = 2 * (order + 1);
% state_data = 2-D structure
% state_data(trials, angles).state = matrix (2 * (order + 1)) x (number of bins + 1)
% n_bin_max = % max index of bin for each trial and each angle : matrix
% trials x angle
%

n_points = size(training_data(i_t, i_a).spikes, 2);
n_bins = floor((n_points - 300) / bin_size) - order;

% state at the end point of each bin + initial state
state_size = 2 * (order + 1);
state = zeros(state_size, n_bins + order + 1);

% forward : v_k = x_k+1 - x_k
type = 'forward';
if (strcmp(type, 'forward'))
    
    points = 300 + (0 : bin_size : ((n_bins + order)*bin_size));
    
    % x
    state(1, :) = training_data(i_t, i_a).handPos(1, points);
    % y
    state(2, :) = training_data(i_t, i_a).handPos(2, points);
    
    for i_o = 1:order
        
        % d^(i_o)x / dt^(i_o)
        state(2 * i_o + 1, 1:(n_bins + order)) = diff(state(2 * (i_o - 1) + 1, :)) / bin_size;
        % d^(i_o)y / dt^(i_o)
        state(2 * i_o + 2, 1:(n_bins + order)) = diff(state(2 * (i_o - 1 ) + 2, :)) / bin_size ;
    end
    
    state = state(:, 1:(n_bins+1));
    
% backward : v_k = x_k - x_k-1   
else
    
    points = 300 + ((-order * bin_size) : bin_size : (n_bins *bin_size));
    
    % x
    state(1, :) = training_data(i_t, i_a).handPos(1, points);
    % y
    state(2, :) = training_data(i_t, i_a).handPos(2, points);
    
    for i_o = 1:order
        
        % d^(i_o)x / dt^(i_o)
        state(2 * i_o + 1, 2:(n_bins + order + 1)) = diff(state(2 * (i_o - 1) + 1, :)) / bin_size;
        % d^(i_o)y / dt^(i_o)
        state(2 * i_o + 2, 2:(n_bins + order + 1)) = diff(state(2 * (i_o - 1 ) + 2, :)) / bin_size;
    end
    
    state = state(:, (order+1):(n_bins + order + 1));
    
end

end

%%
%
%