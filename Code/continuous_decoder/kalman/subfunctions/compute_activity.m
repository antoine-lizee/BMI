%%
%
%
function activity = compute_activity(training_data, bin_size, i_t, i_a, order, selected_neurons)

% size(state) = 2 * (order + 1);
% state_data = 2-D structure
% states(trials).activity = nb_neurons x (number of bins)

n_points = size(training_data(i_t, i_a).spikes, 2);
n_bins = floor((n_points - 300) / bin_size) - order;

time_max = 300 + n_bins * bin_size;

% state at the end point of each bin + initial state
nb_neurons = size(selected_neurons, 2);
activity = zeros(nb_neurons, n_bins);

%     training_data(n,k).spikes(i,t)  (i = neuron id, t = time)
for i_n = 1:nb_neurons
    
    neuron = selected_neurons(i_n);
    
    raw_activity = training_data(i_t, i_a).spikes(neuron, 301:time_max);
    ind=reshape(1:size(raw_activity,2),bin_size,n_bins);
    spike_count = sum(raw_activity(ind),1);
    
    activity(i_n, :) = spike_count / bin_size;
    
end


end

%%
%
%