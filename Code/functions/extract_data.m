%% extract_data
%
% Returns the data from raw_data in an 4D matrix
% (trial x angle x neuron x time) easier to manipulate.
%
% No size check are perforned! Relying entirely on Matlab's handling of
% out-of-ranges ... so get your queries right !
% (In particular, note that for different trials / angles, the max. time
% is usually not the same !)
%
function rep = extract_data(raw_data, trials, angles, neurons, time_points)

% first 300ms by default
if nargin < 5
    time_points = 1:300;
end

% all neurons by default
if nargin < 4
    neurons = 1:size(raw_data(1, 1).spikes,1);
end

% all angles by default
if nargin < 3
    angles = 1:size(raw_data, 2);
end

% all trials by default
if nargin < 2
    trials = 1:size(raw_data, 1);
end

rep = zeros(length(trials), length(angles), length(neurons), length(time_points));

% copying...
for index_trial = trials
    for index_angle = angles
        rep (index_trial, index_angle,  1:length(neurons), 1:length(time_points)) = raw_data(index_trial, index_angle).spikes(neurons, time_points);
    end
end
end
%%
% END
%
