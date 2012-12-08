%% select_neuron
% Selects neuron based on a 'goodness' coefficient (the smaller, the better)
% goodness = (mean squared error of the fitting) / (amplitude of the cos);
%          = 'R2smart' / coeff
%
function index_selected_neuron1 = select_neuron(matrix_data_300)

nb_neurons = size(matrix_data_300, 3);
% nb of spikes for each neuron, each trial and each angle
spike_count = sum(matrix_data_300(:, :, :, :), 4);

%MSE = zeros(1, nb_neurons);
MSEsmart = zeros(1, nb_neurons);
coeff = zeros(1, nb_neurons);
dist_ratio = zeros(1, nb_neurons);
angles = zeros(1, nb_neurons)';

for index_neuron = 1:nb_neurons
    
    param = get_param_tuning_curve(spike_count(:, :, index_neuron), 'cos');
    
    %MSE(index_neuron) = param.MSE;
    MSEsmart(index_neuron) = param.MSEsmart;
    coeff(index_neuron) = param.coeff;
    angles(index_neuron) = param.pref_direc_rad;
    dist_ratio(index_neuron) = sum(param.dist_ratio);
end

nb_selected_neurons = 20;

goodness1 = MSEsmart ./ (coeff.^2);
goodness2 = MSEsmart ./ dist_ratio;


[~, sorted_index_goodness1] = sort(goodness1);
index_selected_neuron1 = sorted_index_goodness1(1:nb_selected_neurons);

[~, sorted_index_goodness2] = sort(goodness2);
index_selected_neuron2 = sorted_index_goodness2(1:nb_selected_neurons);

angles_selected_neuron1 = angles(index_selected_neuron1);
% sorted_goodness(1:10);


second_selec = [5 6 7 8 9 12 13 14 18 20];
index_selected_neuron1 = index_selected_neuron1(second_selec);
angles_selected_neuron1 = angles_selected_neuron1(second_selec);
mod(angles_selected_neuron1 * 180 / pi, 360)


polar((angles_selected_neuron1*[1,1])', [ones(10,1),zeros(10,1)]' ,'-or')


% % angle values
% angles = [30 70 110 150 190 230 310 350];
% figure;
% for i = 1:10
%     subplot(5,2,i);
%  
%     errorbar(angles, mean_nb_spikes, std_nb_spikes, 'k');
%     set(gca,'XTick', angles);
%     
%     param = get_param_tuning_curve(spike_count, 'cos');
%     
%     a_deg = 0:360;
%     hold on;
%     plot(a_deg, param.baseline + param.coeff * cos(a_deg * pi / 180 - param.pref_direc_rad), '-r');
%     hold on;
%     plot(a_deg, param.baseline, '-b');
% end
% 
% index_selected_neuron1
% index_selected_neuron2
end
%%
% END
%