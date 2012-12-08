%%
%
%
function [A, W, MX_p, MX_f] = trajectory_parameters_kalman(states)

% size(state) = 2 * (order + 1);
% state_data = 2-D structure
% states(trials).state = matrix (2 * (order + 1)) x (number of bins + 1)

size_state = size(states(1).state, 1);
n_trials = length(states);
nb_bin_max_trial = arrayfun(@(x)size(x.state, 2), states);


A1 = zeros(size_state);
A2 = zeros(size_state);

W1 = zeros(size_state);
W2 = zeros(size_state);

X_1 = zeros(size_state, 1);
X_2 = zeros(size_state, 1);

for i_t = 1:n_trials
    
    bin_max = nb_bin_max_trial(i_t);
    

    x1 = states(i_t).state(:, 2:bin_max);
%     x1_m = mean(x1, 2);
%     x1 = x1 - repmat(x1_m, [1 bin_max-1]);
    
    x2 = states(i_t).state(:, 1:(bin_max-1));
%     x2_m = mean(x2, 2);
%     x2 = x2 - repmat(x2_m, [1 bin_max-1]);
    
    A1 = A1 + x1 * x2';
    A2 = A2 + x2 * x2';
    
    W1 = W1 + (1 / (bin_max-1)) * (x1 * x1');
    W2 = W2 + (1 / (bin_max-1)) * (x2 * x1');
    
%     X_1 = X_1 + x1_m;
%     X_2 = X_2 + x2_m;
end

A = A1 / A2;
W = W1 - A * W2;

MX_f = X_1 / n_trials;
MX_p = X_2 / n_trials;

end
%%
%
%