%% extract_test_data
%
% Returns the data from test_data in an 3D matrix
% ( neuron x time x trial) ready to be inputed in the decode function.
%
% Copyright O.E. @ Mashed Potatoes @ ICL, 05/03/2012

function rep = extract_test_data(raw_data, trials, neurons, time_points)

% first 300ms by default
if nargin < 4
    time_points = 1:300;
end

% all neurons by default
if nargin < 3
    neurons = 1:size(raw_data(1).spikes,1);
end

% all trials by default
if nargin < 2
    trials = 1:length(raw_data);
end

rep = zeros( length(neurons), length(time_points), length(trials));

% copying...
for index_trial = trials
    rep (neurons, time_points,index_trial) = raw_data(index_trial).spikes(neurons, time_points);
end
end
%%
% END
%
