%% get_param_tuning_curve
% Returns the parameters to fit a cos function to the tuning curve of one
% neuron.
% 'method' can be 'basic cos' or 'truncated cos' (last one by default)
%
function param = get_param_tuning_curve(nb_spikes, method)

% truncated cos method by default
if nargin < 2
    method = 'truncated cos';
end
%

mean_nb_spikes = mean(nb_spikes, 1);

all_angles = [30 70 110 150 190 230 310 350];
all_angles_rad = (all_angles * pi / 180)';

if (strcmp(method,'cos'))
    
    % matrix of basis function ;
    % fitting 'w1 + w2 * cos(x) + w3 * sin(x)' here
    phi = [ones(8, 1), cos(all_angles_rad), sin(all_angles_rad)];
    
    % obtaining w with the Moore-Penrose pseudo-inverse (least square error)
    w = pinv(phi) * mean_nb_spikes';
    
    % some trigonometry :
    % transforming 'w2 * cos(x) + w3 * sin(x)' in 'a  * cos(x - theta)'
    % a = sqrt(w2^2+w3^2), theta = atan(w(3)/w(2)) if w2 >0,
    % theta = atan(w(3)/w(2)) + pi otherwise
    % theta is the preferred direction
    pref_direc_rad = atan2(w(3), w(2));
    %
    
    % difference between mean point and estimate
    nb_trials = size(nb_spikes, 1);
    estimate = phi * w;
    MSE = mean_nb_spikes' - estimate;
    % squared error
    MSE = mean(MSE.^2);
    
    % 'smart' MSE
    MSEsmart = nb_spikes - repmat(estimate', nb_trials, 1);
    MSEsmart = MSEsmart.^2;
    MSEsmart = mean(mean(MSEsmart));
    
    % 'distinction' ratio
    dist_ratio = zeros(1, 8);
    for (index_angle = 1:8)
        ip1 = mod(index_angle, 8)+1;
        im1 = mod(index_angle-2, 8)+1;
        
        for index_trial = 1:size(nb_spikes, 1)
            vi = nb_spikes(index_trial, index_angle);
            vip1 = nb_spikes(ip1, index_angle);
            vim1 = nb_spikes(im1, index_angle);
            
            dist_ratio(index_angle) = dist_ratio(index_angle) + (vi-vip1)^2 + (vi-vim1)^2;
        end
    end
    
    
    param = struct('baseline', w(1), 'coeff', sqrt(w(2)^2+w(3)^2),...
        'pref_direc_rad', pref_direc_rad, 'method', 'cos', 'MSE', MSE,...
        'MSEsmart', MSEsmart, 'dist_ratio', dist_ratio);
    % truncated cos method by default
    
    %% the code below is not yet completely finished ...
    %(but this version is working)
else
    
    max_nb_iterations = 10;
    precision_rad = 1 * pi / 180;
    
    % see the 'basic cos' method for more explanations
    % first obtention of the preferred direction with all the points
    phi = [ones(8, 1), cos(all_angles_rad), sin(all_angles_rad)];
    w = pinv(phi) * mean_nb_spikes';
    pref_direc_rad = atan2(w(3), w(2));
    
    it_nb = 1;
    delta_angle = pi;
    
    % refining the fit : only taking into account points that fall in
    % prefered direction +/- pi/2 and using the others to compute the baseline
    while (it_nb < max_nb_iterations && delta_angle > precision_rad)
        
        % **
        % finding the points that fall between prefered direction +/- pi/2 rad
        pref_dir = pref_direc_rad * 180 / pi;
        angle_min = pref_dir - 90;
        angle_max = pref_dir + 90;
        angle_min = ceil((angle_min - 30) / 40) * 40 +30;
        angle_max = floor((angle_max - 30)/ 40) * 40 +30;
        
        a = angle_min;
        % relevant angles
        angles = zeros(1,5);
        % their respective index
        indexes = zeros(1,5);
        i = 1;
        
        while a <= angle_max
            if (wrapTo360(a)~= 270)
                a360 =  wrapTo360(a);
                angles(i) = a360;
                
                if (a360 < 270)
                    indexes(i) = (a360 -30) / 40 + 1;
                else
                    indexes(i) = (a360 -30) / 40;
                end
                
                i = i + 1;
            end
            a = a+40;
        end
        angles = angles(angles~=0);
        indexes = indexes(indexes~=0);
        % **
        
        % re-obtention of the preferred direction, see the 'basic cos'
        % method for more explanations
        angles_rad = (angles * pi / 180)';
        phi = [ones(length(angles), 1), cos(angles_rad), sin(angles_rad)];
        w = pinv(phi) * mean_nb_spikes(indexes)';
        new_pref_direc_rad = atan(w(3)/w(2));
        
        % value in [O;2pi] if not already
        if w(2) < 0
            new_pref_direc_rad = new_pref_direc_rad + pi;
        elseif pref_direc_rad < 0
            new_pref_direc_rad = wrapTo2Pi(new_pref_direc_rad);
        end
        
        
        delta_angle = abs(new_pref_direc_rad - pref_direc_rad);
        it_nb = it_nb + 1;
        
        pref_direc_rad = new_pref_direc_rad;
    end
    
    param = struct('baseline', w(1), 'coeff', sqrt(w(2)^2+w(3)^2),...
        'pref_direc_rad', pref_direc_rad, 'method', 'truncated cos');
end

end
%%
% END
%