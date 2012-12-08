%%
%
% stimulus response is one time-response for the 10 selected neurons, for
% one unknown reaching angle
%
% 'stimulus_response' is a neuron x time = 10 x 300 matrix 
% 'parameters' is a structure containing 'baselines', 'coeffs',
% 'pref_direcs', which are 10 x 1 vectors
%

function index_guessed_angle = decode_cos(stimulus_response, parameters)

spike_count = sum(stimulus_response, 2);
% normalised response of the 10 selected neurons
spike_count = (spike_count - parameters.baselines) ./ parameters.coeffs;

U = [cos(parameters.pref_direcs), sin(parameters.pref_direcs)];
%pinvU = (U' * U)\U';
stim_vector = pinv(U) * spike_count;

% guessed angle of reaching
angle = atan2(stim_vector(2), stim_vector(1));
angle_deg = angle * 180 / pi;

% finding the index of the closest angle
[~, index_guessed_angle] = min(mod(angle_deg-[30 70 110 150 190 230 310 350], 360));

end

%%
% END
%