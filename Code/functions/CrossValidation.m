function [ e E conf] = CrossValidation( act_neur, method, ratio, n_cv, rand )
%CROSSVALIDATION is a generic file to do cross validation in order to test
%our algorithms.
%   - "act_neur" is the complete 4D matrix of the activity of neurons for the
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

n_t=size(act_neur,1);
n_a=size(act_neur,2);
n_n=size(act_neur,3);
n_T=size(act_neur,4);


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
tot_a_given=[];
tot_a_test=[];
for i_cv=1:n_cv
    % extract the right data for training and testing
    train_act=act_neur(ind_cv(1:n_train,i_cv),:,:,:);
    test_act=act_neur(ind_cv(n_train+1:end,i_cv),:,:,:);
    % The information for decoding must be in the right "shape" :
    test_trials=reshape(test_act,n_test*n_a,n_n,n_T); % Fu**ing dangerous, but tested.
    test_trials=permute(test_trials,[2 3 1]); % put the right dimension order
    a_giv=repmat(1:8,n_test,1);
    a_giv=a_giv(:)';
    % Perform the actual decoding
    param=getparam(train_act,method);
    a_test=decode(test_trials,param);
    %Quantifying the error
    Ei=errorc(a_test,a_giv);
    Etot(i_cv)=sum(Ei);
    E(i_cv,:)=sum(reshape(Ei,8,[])',1);
    %A(i_cv,:)=a_test;% DEBUG ONLY
    %confusion(i_a,a_test)=confusion(i_a,c)+1;
    tot_a_given=[tot_a_given, a_giv];
    tot_a_test=[tot_a_test, a_test];
end

Em=Etot/(n_test*n_a);
e=mean(Em);

conf=confusionmat(tot_a_given,tot_a_test);
end

