function plot_velocity(struct_trial,t0_window)
%PLOT_VELOCITY is a plot function to display the velocity
%   - "struct_trial" is the array of structures - trials.
%
%   Copyright N.D. @ Mashed Potatoes @ ICL 10/03/2012



if nargin<2
    t0_window = 1; % Initialise time at 1ms
end

[n_trials,n_angles] = size(struct_trial);

% trials durations
t_trials = arrayfun(@(x)length(x.handPos), struct_trial);
% find duration max/min for each angle
t_max_angles = max(t_trials);
t_min_angles = min(t_trials);


% figure vx(t), vy(t) and vy(vx)
h1 = figure();
set(h1,'Visible','off')
subplot(2,2,1);
hold on
xlabel('time (ms)')
ylabel('v_x (cm/ms)')
title('v_x(t)');
xlim([t0_window max(t_max_angles)]) 
subplot(2,2,3);
hold on
xlabel('time (ms)')
ylabel('v_y (cm/ms)')
title('v_y(t)');
xlim([t0_window max(t_max_angles)]) 
subplot(2,2,[2 4]);
hold on;
axis equal;
xlabel('v_x (cm/ms)')
ylabel('v_y (cm/ms)')
title('vy(vx)');


% Pre-alloc
x_mean = cell(n_angles,1);
y_mean = cell(n_angles,1);
x_std = cell(n_angles,1);
y_std = cell(n_angles,1);
vx_mean = cell(n_angles,1);
vy_mean = cell(n_angles,1);


color_traj = [1 0.75 0.75 ; 0.75 0.75 1 ;   0.75 1 0.75;    1 0.75 0.75 ;      1 0.75 1 ;      0 0.5 1 ;   0.75 0.75 0.75 ;   0.5 1 0.75];
color_mean = [1 0 0 ;       0 0 1 ;         0 1 0 ;         1 0.5 0 ;         1 0 1 ;         0 0.15 1 ;         0 0 0 ;         0 0.75 0.25];


t0 = t0_window;

    
for index_angle = 1:n_angles
    
    x_tmin = zeros(n_trials,t_min_angles(index_angle));
    y_tmin = zeros(n_trials,t_min_angles(index_angle));
    vx_tmin = zeros(n_trials,t_min_angles(index_angle)-1);
    vy_tmin = zeros(n_trials,t_min_angles(index_angle)-1);
        
    for index_trial = 1:n_trials
               
        t = 1:1:t_trials(index_trial,index_angle);
        tf = length(t);
        x = struct_trial(index_trial,index_angle).handPos(1,:);
        x_tmin(index_trial,:)= x(1:t_min_angles(index_angle));
        vx = diff(x);
        vx_tmin(index_trial,:) = vx(1:t_min_angles(index_angle)-1);
        y = struct_trial(index_trial,index_angle).handPos(2,:);
        y_tmin(index_trial,:) = y(1:t_min_angles(index_angle));
        vy = diff(y);
        vy_tmin(index_trial,:) = vy(1:t_min_angles(index_angle)-1);
        
        subplot(2,2,1)
        plot(t(t0:tf-1),vx(t0:tf-1),'color',color_traj(index_angle,:))
        subplot(2,2,3)
        plot(t(t0:tf-1),vy(t0:tf-1),'color',color_traj(index_angle,:))
        subplot(2,2,[2 4])
        plot(vx(t0:tf-1),vy(t0:tf-1),'color',color_traj(index_angle,:))

    end
    
    x_mean{index_angle} = mean(x_tmin,1);
    y_mean{index_angle} = mean(y_tmin,1);
    x_std{index_angle} = std(x_tmin,1,1);
    y_std{index_angle} = std(y_tmin,1,1);
    vx_mean{index_angle} = mean(vx_tmin,1);
    vy_mean{index_angle} = mean(vy_tmin,1);
    
    
end


t0 = t0_window;

for index_angle = 1:n_angles
    
    vx = vx_mean{index_angle};
    vy = vy_mean{index_angle};

    tf = t_min_angles(index_angle);
    
    subplot(2,2,1)
    plot(t0:tf-1,vx(t0:tf-1),'color',color_mean(index_angle,:),'LineWidth',2)
    subplot(2,2,3)
    plot(t0:tf-1,vy(t0:tf-1),'color',color_mean(index_angle,:),'LineWidth',2)
    subplot(2,2,[2 4])
    plot(vx(t0:tf-1),vy(t0:tf-1),'color',color_mean(index_angle,:),'LineWidth',2)
    
end





figure(h1)







end




