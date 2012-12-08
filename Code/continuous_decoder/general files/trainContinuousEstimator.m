%%
%
%
function modelParameters = trainContinuousEstimator(training_data, method)

% case method ... to write ..
% load('poolNeurons');
% test_neurons =
% [1,2,12,14,15,16,17,19,23,24,25,26,28,29,32,33,37,39,42,43,45,48,50,51,53
% ,54,57,60,61,62,63,67,68,72,78,82,85,87,88,89,91,92,94,95,98];
suppl_neurons = [15,26,37,39,48,60,85,87,98];
selected_neurons = [3,4,7,9,13,18,22,27,34,35,36,40,41,47,55,56,58,59,64,65,66,71,75,77,80,81,86,96,97,suppl_neurons];
order=4;
bin_size=20;
modelParameters = trainContinuousEstimator_kalman(training_data, order, bin_size, selected_neurons);

end
%%
%
%