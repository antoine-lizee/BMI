

function modelParameters = train_MTM(training_data, order, bin_size, neurons_cont, neurons_class)

modelParameters = trainContinuousEstimator_kalman(training_data, order, bin_size, neurons_cont);

time_points = 300 + (1:10) * bin_size;
n_t = size(training_data, 1);
param = struct([]);

for i_t = 1:10
    
    last_t = time_points(i_t);
    
    neur_act = extract_data(training_data, 1:n_t, 1:8, neurons_class, 200:last_t);
    p = getparam_LL( neur_act, 'mixte');
    
    param= [param p]; %#ok<AGROW>
end

[modelParameters.param] = deal(param);
[modelParameters.neurons_class] = deal(neurons_class);

end

