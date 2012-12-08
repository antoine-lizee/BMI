function [ e E ] = CrossValidationcont( trials, method, ratio, n_cv, rand )
%CROSSVALIDATION is a generic file to do cross validation in order to test
%our algorithms.
%   - "trials" is the complete 4D matrix of the activity of neurons for the
%   n_t trials in the n_a directions. 
%   - "method" is string designing the method used for the decoding algorithm
%   - "ratio" is the ratio of the data that will be part out for testing
%   the data after training. (e.g. ratio=0.1) If ratio=1, the algorithm
%   performs a classical all-but-one-train cross validation.
%   - "n_cv" is the number of cross validation to be performed.
%   - if "rand" is supplied and takes the value 0, the indexes of the
%   trials are not randomised before the cross validation.
%
%   Copyright A.L. @ Mashed Potatoes @ ICL 02/03/2012

n_t=size(trials,1);
n_a=size(trials,2);
n_n=size(trials,3);
n_T=size(trials,4);


if nargin < 5
    rand=1;
end
rand=logical(rand);

if ratio==1
    n_test=1;
    n_cv=n_t;
else
    n_test=floor(ratio*n_t);
end

n_train=n_t-n_test;

%% Computation of the indexes for all the cross validations
ind_cv=zeros(n_t,0);
n_while=n_cv;
while n_while>0
    n_while=n_while-n_t;
    if rand
        index=randperm(n_t)';
    else
        index=(1:n_t)';
    end
    
    % Meshgrid trick:
    index=repmat(index,2,1);
    [X Y]=meshgrid(floor(linspace(0,n_train,n_cv)),(1:n_t));
    ind_index=X+Y; % OH YEAH
    ind_cv=[ind_cv index(ind_index)];    
end

%% Perform the cross validations
Etot=zeros(1,n_cv);
E=zeros(n_cv,8);
%A=zeros(n_cv,n_a*n_trial); % DEBUG ONLY

for i_cv=1:n_cv
    disp(i_cv);
    % extract the right data for training and testing
    train_data=trials(ind_cv(1:n_train,i_cv),:);
    test_data=trials(ind_cv(n_train+1:end,i_cv),:);
    % The information for decoding must be in the right "shape" :
    %OKAY for the test data, reformatted in the trajectories decoder
    traj_giv=get_binned_traj({test_data.handPos},20);
    % Perform the actual decoding
    modelParameters=trainContinuousEstimator(train_data,method);
    traj_test=trajectoriesEstimator(test_data,modelParameters);
    %Quantifying the error
    Ei=errortraj(traj_test,traj_giv);
    Etot(i_cv)=mean(Ei);
    E(i_cv,:)=mean(reshape(Ei,8,[])',1);
    %A(i_cv,:)=a_test;% DEBUG ONLY
end

e=mean(Etot);

end

