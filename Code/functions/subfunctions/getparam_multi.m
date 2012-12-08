function [ param ] = getparam_multi( act_neur, method )
%GETPARAM_LL extracts the parameters from the neurons that caracterise
%prior knowledge. The output is a structure, needed as an input of the
%"decode" function. This is a private version that regroups all the
%getparam functions which are used for the ,aximum Likelyhood decoding
%method ("LL").
%   This structure encapsulates two type of information. The first
%   information is the method which will be used for decoding, and is the
%   input argument of "method" of this function. The second information is
%   the actual coefficients that are extracted from the activity of the
%   recorded neurons. An additional information caracterises the precision
%   of the method that we use for parametrisation of prior knowlledge.
%   - act_neur is a n_t*n_a*n_n*n_T matrix whith the activity of n_n neurons
%   through n_T bins of time (here, n_T=300), for n_t trials
%   - method is a string that caracterises the method that will be used for
%   further decoding, on which the parametrisation of the prior knowledge
%   depends.
%   The coefficient table records the parameters (dim3) for the 10 neurons (dim 1)
%    and 8 angles(dim2).
%
%   Copyright A.L @ Mashed_Potatoes @ ICL. 01/03/12

n_t=size(act_neur,1);
n_a=size(act_neur,2);
n_n=size(act_neur,3);
n_T=size(act_neur,4);

if n_T~=300 && n_n~=10;
    warning('the input may not fit the classical data used for this experiment (10 neurons, 300 ms)');
end

sum_act=sum(act_neur,4);
%USELESS: mean_act=permute(mean_act, [3 2 1]); % Permute the matrix to work in the right dimensions.

% Specifying the number of paramters depending on the method used :
switch method
    case{'gauss', 'binom','gamma'}
        n_param=2;
    case 'mixte'
        n_param=3;
end

nt_binom=100;
mu_thre=1; % Threshold for binomial fit
cov_thre=0.18; % Threshold for truncating of covariance matrix
L=0.5; % Parameter of the linear combination

cov=cell(n_a,1);
coeff=cov;
mu=cov;
neur_multi=cov;
neur_ind=cov;

for i_a=1:n_a
    mu_a=squeeze(mean(sum_act(:,i_a,:),1));
    ind=1:n_n;
    neur_multi{i_a}=ind(mu_a>mu_thre);
    neur_ind{i_a}=ind(mu_a<=mu_thre);
    n_nind=length(neur_ind{i_a});
    mu{i_a}=mu_a(neur_multi{i_a});
    cov{i_a}=cov_trunc(sum_act(:,i_a,neur_multi{i_a}),cov_thre);
    cov{i_a}=L*cov{i_a}+(1-L)*diag(diag(cov{i_a})); % LINEAR INTERPOLATION
    param_mle=[nt_binom*ones(n_nind,1) zeros(n_nind,1)];
    for i_nind=1:n_nind % 80 iterations is small enough to avoid any search of array optimisation
        [param_mle(i_nind,2) ci_mle]=mle(sum_act(:,i_a,neur_ind{i_a}(i_nind)),'distribution','binomial','ntrials',nt_binom);
%             case 'mixte'
%                 [param_mle ci_mle]=mle(test);
%                 if param_mle(1)<1
%                     [param_mle ci_mle]=mle(test,'distribution','binomial','ntrials',nt_binom);
%                     param_mle=[nt_binom, param_mle,1];
%                 else
%                     param_mle=[param_mle,0];
%                 end  
%         end
    end
    coeff{i_a}=param_mle;
end

param=struct('method',{method},'cov',cov,'mu',mu,'neur_multi',neur_multi,...
    'neur_ind',neur_ind,'coeff',coeff,'n_n',n_n,'n_a',n_a,'imp',{[]});

end



