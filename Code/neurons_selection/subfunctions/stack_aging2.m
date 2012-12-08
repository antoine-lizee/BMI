function [ stack2 e_stack2 nonstack2] = stack_aging( e_nn, stack, e_stack, nonstack, T)
%STACK_AGING Summary of this function goes here
%   Detailed explanation goes here
n_n=length(stack);
n_nns=length(nonstack);
%e_n_m=sum(sum(e_stack))/n_n; %mean of the energy for each neuron
e_n_m=max((sum(e_stack,1))); %max of the per neuron energy
for i_nns=randperm(n_nns)
    ind_nns=nonstack(i_nns);
    e_inns=e_nn(stack,ind_nns); % Store energy values for links with the new candidate
    e_inns_m=sum(e_inns,1)*(n_n-1)/n_n; %compute a energy estimate for the candidate neuron
    p=1-1/(1+exp(-(e_inns_m-e_n_m)/(n_n*T)));
    d=rand;
    if p-d>0
        stack2=[stack, ind_nns];
        stack2(i_nns)=[];
        e_stack2=[e_stack, e_inns];
        e_stack2=[e_stack2; e_inns];
        [~, i_n]=max(sum(e_stack2,1));
        ind_n=stack2(i_n);
        e_stack2(:,i_n)=[];
        e_stack2(i_n,i_n:end)=e_stack2(i_n-1,i_n:end);
        e_stack2(i_n,:)=[];
        nonstack2=nonstack;
        nonstack2(i_nns)=ind_n;
        return
    end
    % if nothing happened :
    stack2=stack;
    e_stack2=e_stack;
    nonstack2=nonstack;
end  
end

