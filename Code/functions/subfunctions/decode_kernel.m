function [ C ] = decode_kernel( neur_act, param )
%DECODE Summary of this function goes here
%   Detailed explanation goes here

sum_act=sum(neur_act,2);
n_n=size(param.coeff,1);
n_a=size(param.coeff,2);

ll=zeros(n_n,n_a);
for i_a=1:n_a
    for i_n=1:n_n;
        prob1=param.coeff{i_n,i_a}(1,:);
        prob2=param.coeff{i_n,i_a}(2,:);
        switch param.method
            case 'kgauss'
                ind=find(sum_act(i_n)<prob1,1);
                if isempty(ind)
                    ll(i_n,i_a)=0.0000001;
                else
                    ll(i_n,i_a)=prob2(ind);
                end
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

