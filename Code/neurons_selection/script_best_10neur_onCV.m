n_age=10000;
n_n=20;
stack0=10:19;
T=0.2;

stack=stack0;
n_ns=length(stack);
e_stack=e_nn(stack,stack);
e_stack=e_stack-diag(diag(e_stack));
nonstack=1:n_n;
nonstack(stack)=[];
e=zeros(n_age,1);
stack_hist=zeros(n_age,n_ns);
stack_hist(1,:)=stack0;
for i=1:n_age
    e(i)=sum(sum(e_stack))/((n_ns-1)*n_ns);
    [stack e_stack nonstack]=stack_aging(e_nn,stack,e_stack,nonstack,T,1);
    stack_hist(i+1,:)=stack;
end

[e_sort i_e_sort]=sort(e);
stack_sort=stack_hist(i_e_sort,:);
stack_sort2=sort(stack_sort,2);
%final_stack_sorted=unique(stack_sort2,'rows');
%final_e_sorted=unique(e_sort,'rows');
