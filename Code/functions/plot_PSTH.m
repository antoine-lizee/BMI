function plot_PSTH(neurons,spikes_density_kernel,t,psth_hist,bins_loc,angles)
%PLOT_PSTH plots the peri-stimulus time histogram of a particular neuron
% Plots the distribution of spikes over time course
%   - "neurons" are the indices of the neurons
%   - "angles" are the angles one wants to observe (e.g. 30)
%   - "spikes_density_kernel" is a matrix obtained with "PSTH" function
%   ('time x angle'). Here, if more than one neuron, must be 'time x angle x neuron'

% If ONE neuron specified, plots in one figure for all the angles specified in 'angles'
%       the histogram and the Kernel smoothing density estimate 
%       If in addition all the 8 angles are asked, adds a subplot with all
%       smoothed histograms for the 8 angles
% If MULTIPLE neurons specified, plots in one figure for all the angles specified in 'angles'
%       the Kernel smoothing density estimate; each subplot corresponds to
%       a particular angle
%
%   Copyright N.D. @ Mashed Potatoes @ ICL 09/03/2012


% Check if angles are specified
if nargin<6
    angles = [30 70 110 150 190 230 310 350]; % Plot all angles
end

n_neurons = length(neurons);
n_angles = length(angles);
spk_max = max(max(max(spikes_density_kernel)));

% Prepare subplot according to number of angles specified
if (n_angles==8)
    % To match with the plot of tunning curves with all angles
    angle_positions = [6 3 2 1 4 7 8 9];
    n_row_plot = 3;
    n_column_plot = 3;
    
    ind_spec_angle = 1:8;
    
else
    
    angle_positions = 1:n_angles;  
    if (n_angles<4)
        n_row_plot = 1;
    else
        n_row_plot = 2;
    end
    n_column_plot = ceil(n_angles/n_row_plot);
    
        
    % Find specified angles data
    ind_spec_angle = floor(angles/30);
    % Tidy up indexes
    wrong_ind = [5 6 7 10 11];
    corr_ind = [4 5 6 7 8];
    for k = 1:5
        ind = find(ind_spec_angle==wrong_ind(k));
        if (~isempty(ind))
            ind_spec_angle(ind) = corr_ind(k);
        end
    end
    ind_spec_angle = sort(ind_spec_angle);
    
end

% Colors for each angle - match with plot of trajectories
color_angle = [1 0.75 0.75 ; 0.75 0.75 1 ;   0.75 1 0.75;    1 0.75 0.75 ;      1 0.75 1 ;      0 0.5 1 ;   0.75 0.75 0.75 ;   0.5 1 0.75];
color_density = [1 0 0 ;       0 0 1 ;         0 1 0 ;         1 0.5 0 ;         1 0 1 ;         0 0.15 1 ;         0 0 0 ;         0 0.75 0.25];
marker_neuron = { 's','o','*','x','d'};

legend_kernel = cell(n_angles,1);


figure() 
for index_angle = 1:n_angles
    
    selected_angle = ind_spec_angle(index_angle);
        
    if (n_neurons==1) % Plot histogram
        
        subplot(n_row_plot,n_column_plot,angle_positions(index_angle));
        h1 = bar(bins_loc, psth_hist(:,selected_angle),'hist');
        hold on
        set(h1,'facecolor',color_angle(selected_angle,:))
        % Plot Kernel smoothing density estimate
        plot(t,spikes_density_kernel(:,selected_angle),'Color',color_density(selected_angle,:),'LineWidth',2)
        
        title(['neuron ', num2str(neurons),' - ', num2str(angles(index_angle)), '\circ'],'FontWeight','bold');
        
        % legend for the middle plot with all smoothed hist
        legend_kernel{index_angle} = ['\alpha=',num2str(angles(index_angle)),'\circ'];
        
    else % Plot Kernel smoothing density estimate only
        
        subplot(n_row_plot,n_column_plot,angle_positions(index_angle));
        hold all
        
        for index_neuron = 1:n_neurons 
            plot(t(:,index_neuron),spikes_density_kernel(:,selected_angle,index_neuron),'LineWidth',2)
%             plot(t(1:100:size(t,1),index_neuron),spikes_density_kernel(1:100:size(t,1),selected_angle,index_neuron),'Color',color_density(selected_angle,:),'Marker',marker_neuron{index_neuron},'LineStyle','none')
        end
        
        set(gca,'YGrid', 'on')

        
        title([num2str(angles(index_angle)), '\circ'],'FontWeight','bold');
        
    end   
    

     
    xlabel('time (ms)')
    ylabel('spike rate (spk/ms)')   
    xlim([t(1)-1 length(t)])
    ylim([0 spk_max])
    
    
end


if (n_angles==8)
    
    subplot(n_row_plot,n_column_plot,5)
    hold on
    
    if (n_neurons==1) % Plot smoothed histogram in middle position
        
        for index_angle = 1:n_angles
        
            selected_angle = ind_spec_angle(index_angle);
            
            plot(t,spikes_density_kernel(:,selected_angle),'Color',color_density(selected_angle,:),'LineWidth',2);
            
        
        end
        
        xlabel('time (ms)')
        ylabel('spike rate (spk/ms)')
        title(['Kernel smoothing density estimate - neuron ', num2str(neurons)],'FontWeight','bold');
        xlim([t(1)-1 length(t)])
        legend(legend_kernel)
        
    else
        
%         grid on
%         axis equal
% %         hold on
%         xlim([0 5]); ylim([0 5]);
%         for index_neuron = 1:n_neurons
%             y_neuron = 5-index_neuron*0.9;
%             line([0,1],[y_neuron,y_neuron])
% %             line([0,1],[y_neuron,y_neuron],'Color','k','Marker',marker_ne
% %             uron{index_neuron})
%             text(1.5,y_neuron,['neuron ', num2str(index_neuron)])
%         end
%         set(gca,'YTick',[])
%         set(gca,'XTick',[])

    end

end




end



%%
% END
%
