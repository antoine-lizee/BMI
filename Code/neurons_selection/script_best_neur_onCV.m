et=zeros(1,98);

for i_n=1:98
    et(i_n)=CrossValidation(matrix_data_300(:,:,i_n,:),'gauss',1);
end

[set si_n]=sort(et);

%[33,69,31,90,"3",97,59,"36",44,"34",81,4,27,2,84 ||,7,54,91,93,18]

%[31,33,69,90,59,7,97,81,4,36,44,34,54,27,3,18,91,93,2,41;]