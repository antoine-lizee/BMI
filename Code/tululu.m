close all
clear all
clc

load monkeydata0
% load matrix_data_300


%% test psth

matrix_data_test = extract_data(trial, 1:size(trial,1),1:8,1:98,1:500);
% (raw_data, trials, neurons, time_points)

% n=4;
% neurons = [69 59 90 97];
%  %44
% 
% 
% for k = 1:n
%     [spikes_density_kernel(:,:,k),t(:,k),psth_hist(:,:,k),bins_loc(:,k)] = PSTH(matrix_data_test,neurons(k),30);
% end
% 
% % plot_PSTH(n1,spikes_density_kernel(:,:,1),t(:,1),psth_hist(:,:,1),bins_loc(:,1))
% % plot_PSTH(n1,spikes_density_kernel(:,:,2),t(:,2),psth_hist(:,:,2),bins_loc(:,2))
% % plot_PSTH(n1,spikes_density_kernel(:,:,3),t(:,3),psth_hist(:,:,3),bins_loc(:,3))
% % plot_PSTH(n1,spikes_density_kernel(:,:,1),t(:,1),psth_hist(:,:,1),bins_loc(:,1),[30 190])
% plot_PSTH(neurons,spikes_density_kernel,t,[],[])
% % plot_PSTH([n1,n2],spikes_density_kernel(:,:,1:2),t,[],[],[30 190])


%% test plot trajectories

plot_position(trial);
plot_velocity(trial);
plot_acceleration(trial);
