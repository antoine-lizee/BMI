
if (~exist('trial', 'var'))
    load monkeydata0.mat;
end

bin_size = 20;
order = 4;

%selected_neurons = [3 4 9 18 27 34 36 44 59 69 71 75 77 80 81];
load('poolNeurons');
selected_neurons = poolNeurons3;
neurons_class = poolNeurons;

if (~exist('modelParameters', 'var'))
    modelParameters = train_MTM(trial, order, bin_size, selected_neurons, neurons_class);
end

i_test_trial = 15;
i_test_angle = 7;

test_data.startHandPos = trial(i_test_trial, i_test_angle).handPos(1:2, 300);
test_data.decodedHandPos = [];
n_points_estimated = floor((size(trial(i_test_trial, i_test_angle).handPos, 2) - 300) / bin_size);

estimated_positions = zeros(n_points_estimated+1, 2);
real_positions = zeros(n_points_estimated+1, 2);

start = trial(i_test_trial, i_test_angle).handPos(1:2, 300);

estimated_positions(1, :) =  start;
real_positions(1, :) =  start;

size(trial(i_test_trial, i_test_angle).handPos, 2)

for i_t = 1:n_points_estimated
    
    t = 300 + i_t * bin_size;
    spikes = trial(i_test_trial, i_test_angle).spikes(:, 200:t);
    
    test_data.spikes = spikes;
    [x_e, y_e, modelParameters] = MTM(test_data, modelParameters);
    estimated_positions(i_t+1, :) = [x_e, y_e];
    real_positions(i_t+1, :) = trial(i_test_trial, i_test_angle).handPos(1:2, t);
    
    test_data.decodedHandPos=[1; 2];
    
end


error = estimated_positions - real_positions;
RSE = sqrt(sum(error.^2, 2));
RSE_mean = mean(RSE)

subplot(2,2,1)
plot(real_positions(:,1), real_positions(:,2), 'r-o');
axis equal;
hold on;
plot(estimated_positions(:,1), estimated_positions(:,2), 'b-o');

subplot(2,2,2)
plot(0:n_points_estimated, RSE, 'k-o');

subplot(2,2,3)
plot(0:n_points_estimated, error(:,1), 'k-o');

subplot(2,2,4)
plot(0:n_points_estimated, error(:,2), 'k-o');





