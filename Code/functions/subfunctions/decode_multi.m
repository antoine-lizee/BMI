function [ C ] = decode_multi( neur_act, param )
%DECODE Summary of this function goes here
%   Copyright A.L.@Mashed Potatoes@ICL, London

sum_act=sum(neur_act,2);
n_n=param.n_n;
n_a=param.n_a;
LL=zeros(n_a,1);
ll_multi=zeros(1);
for i_a=1:n_a
    % Unpacking parameters
    cov=param(i_a).cov;
    mu=param(i_a).mu;
    neur_multi=param(i_a).neur_multi;
    neur_ind=param(i_a).neur_ind;
    coeff=param(i_a).coeff;
    % multivariate gaussian estimation
    ll_multi=mvnpdf(sum_act(neur_multi),mu,cov); % It may be more optimal to actually take this out of the loop since mvnpdf can take as input 2D MU and 3D SIGMA...
    % independentestimations
    n_nind=size(neur_ind,2);
    ll_ind=zeros(n_nind,1);
    for i_nind=1:n_nind
        ll_ind(i_nind)=binopdf(sum_act(neur_ind(i_nind)),coeff(i_nind,1),coeff(i_nind,2));
    end
    if n_nind>0
        LL(i_a)=prod(ll_ind,1).*ll_multi;
    else
        LL(i_a)=ll_multi;
    end
end

[max_ll max_a]=max(LL);

if max_ll==0
    error('The decoding has failed because the activity of the neurons provided can''t match with any probable angle');
end

C=max_a;


end

