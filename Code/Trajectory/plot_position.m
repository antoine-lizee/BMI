function plot_position(struct_trial,t0_window)
%PLOT_POSITIONS is a plot function to display the trajectory
%   - "struct_trial" is the array of structures - trials.
%
%   Copyright N.D. @ Mashed Potatoes @ ICL 09/03/2012

if nargin<2
    t0_window = 1; % Initialise time at 1ms
end

[n_trials,n_angles] = size(struct_trial);

% trials durations
t_trials = arrayfun(@(x)length(x.handPos), struct_trial);
% find duration max/min for each angle
t_max_angles = max(t_trials);
t_min_angles = min(t_trials);



% figure x(t), y(t) and y(x)
h2 = figure();
set(h2,'Visible','off')
subplot(2,2,1);
hold on
xlabel('time (ms)')
ylabel('x (cm)')
title('x(t)');
xlim([t0_window max(t_max_angles)]) 
subplot(2,2,3);
hold on
xlabel('time (ms)')
ylabel('y (cm)')
title('y(t)');
xlim([t0_window max(t_max_angles)]) 
subplot(2,2,[2 4]);
hold on;
axis equal;
xlabel('x (cm)')
ylabel('y (cm)')
title('y(x)');

x_mean = cell(n_angles,1);
y_mean = cell(n_angles,1);


color_traj = [1 0.75 0.75 ; 0.75 0.75 1 ;   0.75 1 0.75;    1 0.75 0.75 ;      1 0.75 1 ;      0 0.5 1 ;   0.75 0.75 0.75 ;   0.5 1 0.75];
color_mean = [1 0 0 ;       0 0 1 ;         0 1 0 ;         1 0.5 0 ;         1 0 1 ;         0 0.15 1 ;         0 0 0 ;         0 0.75 0.25];


t0 = t0_window;
    
for index_angle = 1:n_angles
    
    
    x_tmin = zeros(n_trials,t_min_angles(index_angle));
    y_tmin = zeros(n_trials,t_min_angles(index_angle));
        
    for index_trial = 1:n_trials
        
        t = 1:1:t_trials(index_trial,index_angle);
        tf = length(t);
        x = struct_trial(index_trial,index_angle).handPos(1,:);
        x_tmin(index_trial,:)= x(1:t_min_angles(index_angle));
        y = struct_trial(index_trial,index_angle).handPos(2,:);
        y_tmin(index_trial,:) = y(1:t_min_angles(index_angle));
           
        subplot(2,2,1)
        plot(t(t0:tf),x(t0:tf),'color',color_traj(index_angle,:))
        subplot(2,2,3)
        plot(t(t0:tf),y(t0:tf),'color',color_traj(index_angle,:))
        subplot(2,2,[2 4])
        plot(x(t0:tf),y(t0:tf),'color',color_traj(index_angle,:))
               
       
    end
    
    x_mean{index_angle} = mean(x_tmin,1);
    y_mean{index_angle} = mean(y_tmin,1);
    
    
end



t0 = t0_window;

for index_angle = 1:n_angles
    
    x = x_mean{index_angle};
    y = y_mean{index_angle};

    tf = t_min_angles(index_angle);
    
    subplot(2,2,1)
    plot(t0:tf,x(t0:tf),'color',color_mean(index_angle,:),'LineWidth',2)
    subplot(2,2,3)
    plot(t0:tf,y(t0:tf),'color',color_mean(index_angle,:),'LineWidth',2)
    subplot(2,2,[2 4])
    plot(x(t0:tf),y(t0:tf),'color',color_mean(index_angle,:),'LineWidth',2)
    
end


figure(h2)


end




