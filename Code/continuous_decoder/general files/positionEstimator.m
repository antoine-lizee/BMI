function [x, y, modelParameters] = positionEstimator(test_data, modelParameters)
% - test_data:
%     test_data(m).trialID
%         unique trial ID
%     test_data(m).startHandPos
%         2x1 vector giving the [x y] position of the hand at the start
%         of the trial
%     test_data(m).decodedHandPos
%         [2xN] vector giving the hand position estimated by your
%         algorithm during the previous iterations. In this case, N is
%         the number of times your function has been called previously on
%         the same data sequence.
%     test_data(m).spikes(i,t) (m = trial id, i = neuron id, t = time)
%     in this case, t goes from 220 to the current time in steps of 20
%     Example:
%         Iteration 1 (t = 320):
%             test_data.trialID = 1;
%             test_data.startHandPos = [0; 0]
%             test_data.decodedHandPos = []
%             test_data.spikes = 98x120 matrix of spiking activity
%         Iteration 2 (t = 340):
%             test_data.trialID = 1;
%             test_data.startHandPos = [0; 0]
%             test_data.decodedHandPos = [2.3; 1.5]
%             test_data.spikes = 98x140 matrix of spiking activity



% if method == 'kalman'
%[x, y, modelParameters] = positionEstimator_kalman(test_data, modelParameters);
% elseif method == 'modified kalman'
% end

[x, y, modelParameters] = MTM(test_data, modelParameters);

%

% Return Value:

% - [x, y]:
%     current position of the hand

end