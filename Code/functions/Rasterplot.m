function [ h ] = Rasterplot( act_neur , i_n, i_t, fig)
%RASTERPLOT Summary of this function goes here
%   Detailed explanation goes here

n_t=size(act_neur,1);
n_a=size(act_neur,2);
n_n=size(act_neur,3);
n_T=300;%size(trials(1,1).spikes,2);

if nargin<2
    i_n=0; % Do Raster plot for hole population
    i_t=1; % Indice of the trial
end

n_nf=length(i_n); %number of neurons to display
n_tf=length(i_t); %number of trials to display

if nargin<4
    fig=100;
end

if i_n==0 %population plot
    subx=n_tf;
    suby=n_a;
    for ind_t=1:n_tf
        for i_a=1:n_a
            subplot(subx,suby,ind_t*n_a+ind_t)
            Raster(squeeze(act_neur(i_tf(ind_t),i_a,:,:)));
        end
    end
else % trial plot
    suby=n_nf;
    subx=n_a;
    for ind_n=1:n_nf
        [kernel, t] = PSTH(act_neur,i_n(ind_n),30);
        for i_a=1:n_a
            subplot(suby,subx,(ind_n-1)*n_a+i_a)
            Raster(squeeze(act_neur(i_t,i_a,i_n(ind_n),:)));
            hold on
            plot(t,100-kernel(:,i_a)*1000,'Linewidth',2);
            %plot([300 300], [0 100], '--g');
            plot([100 100], [0 100], 'k');
            set(gca,'XTick', [100 300], 'XTickLabel', [300 500],'YTick', []);
        end
    end    
end



% set(gcf,'Units','normalized');
% if i_neuron~=0
%     text(0.5,0.9,['Raster plot for the 8 positions for neuron number ' num2str(i_neuron) 'and all the trials' ],'VerticalAlignment','top','HorizontalAlignment','center');
% else
%     text(0.5,0.9,['Raster plot for the entire population, for 8 positions, for trial ' num2str(i_trial)],'VerticalAlignment','top','HorizontalAlignment','center');
% end
    
    
end

