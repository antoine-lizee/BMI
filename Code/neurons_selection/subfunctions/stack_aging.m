function [ stack2 e_stack2 nonstack2] = stack_aging( e_nn, stack, e_stack, nonstack, T, T2)
%STACK_AGING Summary of this function goes here
%   Detailed explanation goes here
n_n=length(stack);
n_nns=length(nonstack);
%e_n_m=sum(sum(e_stack))/n_n; %mean of the energy for each neuron
e_n_m=max((sum(e_stack,1))); % max of the per neuron energy
for i_nns=randperm(n_nns)
    ind_nns=nonstack(i_nns);
    e_inns=[e_nn(stack,ind_nns); 0]; % Store energy values for links with the new candidate
    e_inns_m=sum(e_inns,1)*(n_n-1)/n_n; %compute a energy estimate for the candidate neuron
    p=1-1/(1+exp(-(e_inns_m-e_n_m)/(n_n*T)));
    d=rand;
    if p-d>0
        % compute extended stack energy matrix
        e_stack2=[e_stack, e_inns(1:end-1)]; 
        e_stack2=[e_stack2; e_inns'];
        % choose the one to remove from the stack (loser)
        [e_stack_s, i_n]=sort(sum(e_stack2(:,1:end-1),1));
        stack_s=stack(i_n);
        p_stack_s=exp(e_stack_s/T2);
        p_stack_s=cumsum(p_stack_s);
        p_stack_s=p_stack_s/p_stack_s(end);
        d2=rand;
        ind=find(p_stack_s>d2,1);
        ind_n=stack_s(ind);
        % create new stack energy matrix
        e_stack2(i_n(ind),:)=[];
        e_stack2(:,i_n(ind))=[];
        % Update nonstack and stack
        stack2=[stack, ind_nns];
        stack2(i_n(ind))=[];
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

