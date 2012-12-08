function [ stack2 e_stack_a2 nonstack2] = stack_aging_angled( e_nn_a, stack, e_stack_a, nonstack, T, T2)
%STACK_AGING Summary of this function goes here
%   Detailed explanation goes here
n_n=length(stack);
n_nns=length(nonstack);
e_n_m=max(cv_err(e_stack_a)); % max of the per neuron energy
for i_nns=randperm(n_nns)
    ind_nns=nonstack(i_nns);
    e_inns=[e_nn_a(stack,ind_nns,:); zeros(1,1,8)]; % Store energy values for links with the new candidate
    e_inns_m=cv_err(e_inns); %compute an energy estimate for the candidate neuron
    p=1-1/(1+exp(-(e_inns_m-e_n_m)/(n_n*T)));
    d=rand;
    if p-d>0
        % compute extended stack energy matrix
        e_stack_a2=[e_stack_a, e_inns(1:end-1,:,:)]; 
        e_stack_a2=[e_stack_a2; permute(e_inns,[2 1 3])];
        % choose the one to remove from the stack (loser)
        [e_stack_a_s, i_n]=sort(cv_err(e_stack_a2(:,1:end-1,:)));
        stack_s=stack(i_n);
        p_stack_s=exp(e_stack_a_s/T2);
        p_stack_s=cumsum(p_stack_s);
        p_stack_s=p_stack_s/p_stack_s(end);
        d2=rand;
        ind=find(p_stack_s>d2,1);
        ind_n=stack_s(ind);
        % create new stack energy matrix
        e_stack_a2(i_n(ind),:,:)=[];
        e_stack_a2(:,i_n(ind),:)=[];
        % Update nonstack and stack
        stack2=[stack, ind_nns];
        stack2(i_n(ind))=[];
        nonstack2=nonstack;
        nonstack2(i_nns)=ind_n;
        return
    end
    % if nothing happened :
    stack2=stack;
    e_stack_a2=e_stack_a;
    nonstack2=nonstack;
end  
end

