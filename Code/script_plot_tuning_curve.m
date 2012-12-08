%% plotting tuning curve

% * * * * *
% checking if the data is already there, trying to import it otherwise
% note that only the first 300ms are used here, see 'extract_data' for
% more details
%
if (~exist('matrix_data_300', 'var'))
    % data not imported in its matrix form ...
    if (~exist('matrix_data_300.mat', 'file'))
        % ... and matrix form not saved in the workspace either ...
        if (~exist('trial', 'var'))
            % ... and original data not imported either
            if(~exist('monkeydata0.mat', 'file'))
                % ... and original data file not saved in the workspace
                % either ... critical failure, we are doomed
                disp('MISSING DATA !');
                return;
            else
                % ... but original data file saved in the workspace,
                % loading it...
                load('monkeydata0.mat');
                % ... and puttting it in a matrix
                matrix_data_300 = extract_data(trial);
            end
        else
            % ... but original data already imported,
            % puttting it in a matrix
            matrix_data_300 = extract_data(trial);
        end
    else
        % ...but data file in the workspace, loading it        
        load('matrix_data_300.mat');
    end
% else
% data already imported in matrix form, nothing to do
end
% * * * * *

% plotting tuning curve for neuron #1
plot_tuning_curve(matrix_data_300, 33);


%%
% END
%