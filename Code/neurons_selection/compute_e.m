for i=1:size(stack_hist,1)
    e_test=e_nn(stack_hist(i,:),stack_hist(i,:));
    e_test=e_test-diag(diag(e_test));
    e2(i)=sum(sum(e_test))/90;
end