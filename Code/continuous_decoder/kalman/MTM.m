

function [ x, y, modelParameters ] = MTM( test_data, modelParameters )


neurons_class = modelParameters(1).neurons_class;

% n_neurons = size(neurons_class, 1);
% n_t = size(test_data.spikes(1, :));

% format test_data into neur_act
% neur_act = matrix n_neurons x n_t
neur_act = test_data.spikes(neurons_class, :);

if isempty(test_data.decodedHandPos)
    [modelParameters.step]=deal(0);
end
step = modelParameters(1).step;


if (modelParameters(1).step < 3 )
    
    param = modelParameters(1).param(step+1);
    LL = decode_LLcont( neur_act, param );
    
    positions = zeros(2, 8);
    
    for i_a = 1:8
        
        [modelParameters.angle] = deal(i_a);
        [x, y, modelParameters] = positionEstimator_kalman(test_data, modelParameters);
        positions(:,i_a) = [x ; y];
    end
    
    [modelParameters.LL] = deal(LL);
    
    LL(LL<0.1) = 0;
    LL = LL / sum(LL, 2);
    
    [~, lastmaxLLangle] = max(LL);
    [modelParameters.lastmaxLLangle] = deal(lastmaxLLangle);
    
    xy = sum(positions .* (ones(2,1) * LL), 2);
    
    x = xy(1);
    y = xy(2);
    
else
    
    [modelParameters.angle] = deal(modelParameters(1).lastmaxLLangle);
    [x, y, modelParameters] = positionEstimator_kalman(test_data, modelParameters);
    
end


end



