%% plot_tuning_curve
%
% Plots the tuning curve of a particular neuron.
% 'matrix_data' MUST BE a 4D matrix
% 'trial x angle x neuron x time' and data for the 8 angles MUST BE
% avalaible.
%
% All trial / time information available for one neuron will be used.
% Format input matrix_data to restrict it
% (e.g. matrix_data(trials, :, :, :) to restrict the data to some trials
% only).
%
% octave 27/02/2012

function plot_tuning_curve(matrix_data, index_neuron)

% nb of spikes for each neuron, each trial and each angle
%spike_count = sum(matrix_data(:, :, index_neuron, :), 4);
spike_count = sum(matrix_data(:, :, index_neuron, 135:300), 4);% - sum(matrix_data(:, :, index_neuron, 1:134), 4);

% basic statistics...

% mean and std nb of spikes for each neuron and each angle, over all considered trials
% 'squeeze' removes a useless dimension
mean_nb_spikes = squeeze(mean(spike_count, 1));
std_nb_spikes = squeeze(std(spike_count, 1, 1));

subplot(3,3,5);
% angle values
angles = [30 70 110 150 190 230 310 350];
errorbar(angles, mean_nb_spikes, std_nb_spikes, 'k');
set(gca,'XTick', angles);

param = get_param_tuning_curve(spike_count, 'cos');

a_deg = 0:360;
hold on;
plot(a_deg, param.baseline + param.coeff * cos(a_deg * pi / 180 - param.pref_direc_rad), '-r');
hold on;
plot(a_deg, param.baseline, '-b');

% this is so that the plot corresponding to one angle is roughly
% positionned on screen as the angle :
%
% 150    110    70         4    3    2               1  2  3
% 190  (curve)  30         5 (curve) 1        -->    4 (5) 6
% 230    310   350         6    7    8               7  8  9
%     [angles]          [angle indexes]    [corresponding plot position #]
%
angle_positions = [6 3 2 1 4 7 8 9];

for (index_angle = 1:8 )
    pos = angle_positions(index_angle);
    
    subplot(3,3,pos);
    bins = min(spike_count(:,index_angle)):1:max(spike_count(:,index_angle));
    if (length(bins)==1)
        bins = 0:1;
    end
    [nb_spikes_bin, bin_loc] = hist(spike_count(:,index_angle), bins);
    % frequency hist
    frq = nb_spikes_bin/sum(nb_spikes_bin);
    %hist(spike_count(:,index_angle));
    bar(bin_loc, frq, 'hist');
    title([num2str(angles(index_angle)), '\circ']);
    
    % adding 25%, 50%, 75% quantiles and mean lines to the plot.
    quant = quantile(spike_count(:,index_angle), [.25 .5 .75]);
    % quick and dirty...
    maxVal = max(frq);
    x = [quant; quant];
    y = [0, 0, 0 ; maxVal, maxVal, maxVal];
    line(x, y, 'Color', 'r', 'LineWidth', 1.5);
    line([mean_nb_spikes(index_angle),mean_nb_spikes(index_angle)], [0, maxVal],...
        'Color', 'g', 'LineWidth', 1.5, 'LineStyle', '--');
end

end
%%
% END
%
