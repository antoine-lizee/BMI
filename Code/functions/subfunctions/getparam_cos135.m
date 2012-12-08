%% getparam_cos2
%
%  act_neur is a n_t * n_a* n_n * n_T matrix whith the activity of n_n neurons
%   through n_T bins of time (here, n_T=300), for n_t trials

function param = getparam_cos135(act_neur, method)

nb_neurons = size(act_neur, 3);
coeffs = zeros(nb_neurons, 1);
baselines = zeros(nb_neurons, 1);
pref_direcs = zeros(nb_neurons, 1);
dist_ratios = zeros(nb_neurons, 8);

% nb of spikes for each neuron, each trial and each angle
spike_count = sum(act_neur(:, :, :, 135:300), 4);% - sum(act_neur(:, :, :, 1:134), 4);

for index_neuron = 1:nb_neurons
    
    p = get_param_tuning_curve(spike_count(:, :, index_neuron), 'cos');
    
    coeffs(index_neuron) = p.coeff;
    baselines(index_neuron) = p.baseline;
    pref_direcs(index_neuron) = p.pref_direc_rad;
    dist_ratios(index_neuron,:) = p.dist_ratio; 
end

param = struct('method', method, 'coeffs', coeffs,'baselines',baselines,...
    'pref_direcs', pref_direcs);

end

%%
% END
%