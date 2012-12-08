function [ C ] = decode_LL( neur_act, param )
%DECODE Summary of this function goes here
%   Detailed explanation goes here

sum_act=sum(neur_act,2);
n_n=size(param.coeff,1);
n_a=size(param.coeff,2);

ll=zeros(n_n,n_a);
for i_a=1:n_a
    for i_n=1:n_n;
        prob=squeeze(param.coeff(i_n,i_a,:));
        switch param.method
            case 'gauss'
                ll(i_n,i_a)=normpdf(sum_act(i_n),prob(1),prob(2));
            case 'binom'
                ll(i_n,i_a)=binopdf(sum_act(i_n),prob(1),prob(2));
            case 'mixte'
                if prob(3)
                    ll(i_n,i_a)=binopdf(sum_act(i_n),prob(1),prob(2));
                else
                    ll(i_n,i_a)=normpdf(sum_act(i_n),prob(1),prob(2));
                end                
            case 'gamma'
                ll(i_n,i_a)=0;
            case 'vector'
                ll(i_n,i_a)=0;            
        end
    end
end
LL=prod(ll,1);
[max_ll max_a]=max(LL);

if max_ll==0
    error('The decoding has failed because the activity of the neurons provided can''t match with any probable angle');
end

C=max_a;


end

