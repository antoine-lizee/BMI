%%
%
%
function [H, Q, M_z, M_x] = observation_parameters_kalman(states)

% size(state) = 2 * (order + 1);
% state_data = 2-D structure
% states(trials).state = matrix (2 * (order + 1)) x (number of bins+1)
% states(trials).activity = nb_neurons x (number of bins)

size_state = size(states(1).state, 1);
nb_neurons = size(states(1).activity, 1);

n_trials = length(states);
nb_bin_max_trial = arrayfun(@(x)size(x.state, 2), states);


H1 = zeros(nb_neurons, size_state);
H2 = zeros(size_state);

Q1 = zeros(nb_neurons, nb_neurons);
Q2 = zeros(size_state, nb_neurons);

M_z = zeros(nb_neurons, 1);
M_x = zeros(size_state, 1);

for i_t = 1:n_trials
    
    bin_max = nb_bin_max_trial(i_t);
    
    m_z = mean(states(i_t).activity, 2);
    z = states(i_t).activity - repmat(m_z, [1 bin_max-1]) ;
    
    % leave point '0' out
    m_x = mean(states(i_t).state(:,2:bin_max), 2);
    x = states(i_t).state(:,2:bin_max) - repmat(m_x, [1 bin_max-1]);
    
    H1 = H1 + z * x';
    H2 = H2 + x * x';
    
    Q1 = Q1 + (1 / bin_max) * (z * z');
    Q2 = Q2 + (1 / bin_max) * (x * z');
    
    M_z = M_z + m_z;
    M_x = M_x + m_x;
    
end

H = H1 / H2;
Q = Q1 - H * Q2;

M_z = M_z / n_trials;
M_x = M_x / n_trials;

end
%%
%
%