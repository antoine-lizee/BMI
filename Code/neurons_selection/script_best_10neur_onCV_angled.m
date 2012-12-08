n_age=1000;
n_n=20;
stack0_a=10:19;
T=0.2;

stack_a=stack0_a;
n_ns=length(stack_a);
e_stack_a=e_nn_a(stack_a,stack_a,:);
for i=1:size(e_stack_a,3)
    e_stack_a(:,:,i)=e_stack_a(:,:,i)-diag(diag(e_stack_a(:,:,i)));
end
nonstack=1:n_n;
nonstack(stack_a)=[];
e_a=zeros(n_age,1);
stack_hist_a=zeros(n_age,n_ns);
stack_hist_a(1,:)=stack0_a;
for i=1:n_age
    e_a(i)=mean(cv_err(e_stack_a),2);
    [stack_a e_stack_a nonstack]=stack_aging_angled(e_nn_a,stack_a,e_stack_a,nonstack,T-(T/10)*i/1000,1);
    stack_hist_a(i+1,:)=stack_a;
end

[e_sort_a i_e_sort_a]=sort(e_a);
stack_sort_a=stack_hist_a(i_e_sort_a,:);
stack_sort_a2=sort(stack_sort_a,2);
%final_stack_sorted=unique(stack_sort2,'rows');
%final_e_sorted=unique(e_sort,'rows');
