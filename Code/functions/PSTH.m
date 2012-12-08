function [spikes_density_kernel,t,psth_hist,bins_loc] = PSTH(matrix_data,index_neuron,bin_size,t0)
%PSTH finds the peri-stimulus time histogram of a particular neuron
% Returns the distribution of spikes over time course
%   - "matrix_data" must be a 4D matrix with all angles
%     'trial x angle x neuron x time'
%   - "index_neuron" is the index of the neuron we want the psth.
%   - "bin_size" is the desired bin size for the histogram.
%   - "t0" sets time the starting time.
%
%   Copyright N.D. @ Mashed Potatoes @ ICL 09/03/2012



% **** Number of trials, angles and trial duration ************************
n_trials = size(matrix_data,1);
n_angles = size(matrix_data,2);
t_trial = size(matrix_data,4);

% **** Time ***************************************************************
if nargin<4
    t0=1; % Initialize time at t0=1ms
end
t = (t0:1:(t0+t_trial-1))'; % Time vector - step 1ms

% **** Spikes *************************************************************
M = permute(matrix_data(:,:,index_neuron,:),[4 1 2 3]);
% 't_spikes' is a 3D matrix 'time x trial x angle' with times of spikes (0
% if no spike) for each trial and angle
t_spikes = M.*repmat(t,[1,n_trials,n_angles,1]); 
% 't_spikes_all_trials' is a 2D matrix '(time x trial) x angle' with times
% of spikes (0 if no spike) for each trial in the first dimension and
% angles in column
t_spikes_all_trials = reshape(t_spikes,[n_trials*length(t),n_angles]); 
% number of spikes for each trial and angle, then find mean over trials
spike_count = sum(matrix_data(:, :, index_neuron, :), 4);
mean_nb_spikes = squeeze(mean(spike_count, 1));


% **** Histogram **********************************************************
if nargin<3
    bin_size=10; % Default size of bin10 ms
end
% position of bin centers 
bins_loc = ((bin_size/2):bin_size:(t_trial-bin_size/2))'; 
n_bins = length(bins_loc);


% **** Preallocations *****************************************************
psth_hist = zeros(n_bins,n_angles);
nb_spikes_bin = zeros(n_bins,n_trials);
spikes_density_kernel = zeros(t_trial,n_angles);
kernel_window = zeros(n_angles);


% **** Loop ***************************************************************
for index_angle = 1:n_angles
    
    % **** Histogram
    
    for index_trial = 1:n_trials      
        % 't_spikes_angle_trial' is a vector with the times of spikes but
        % removing the zeros, for a particular angle the stated trial
        t_spikes_angle_trial = nonzeros( t_spikes(:,index_trial,index_angle) );  
        % count number of spikes in each bin
        nb_spikes_bin(:,index_trial)  = hist( t_spikes_angle_trial ,bins_loc);          
    end
    mean_nb_spikes_bin = mean(nb_spikes_bin,2); % Mean over trials

    psth_hist(:,index_angle) = mean_nb_spikes_bin/bin_size;
     
    
    % **** Kernel smoothing density estimate 
    
    t_spikes_kernel = nonzeros( t_spikes_all_trials(:,index_angle) );
    if(~isempty(t_spikes_kernel))
        [spikes_density_kernel(:,index_angle),~,kernel_window(index_angle)] = ksdensity(t_spikes_kernel,t,'kernel','normal','function','pdf');
    end
    
    % rescale according to the number of spikes
    spikes_density_kernel(:,index_angle)=spikes_density_kernel(:,index_angle)*mean_nb_spikes(index_angle);
        
end


end



%%
% END
%
