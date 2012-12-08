neurons=neurselec; % neurons you want to test

if size(neurons,1)==1 %put the neuron vector in the fist dimension
    neurons=neurons';
end
n_n=length(neurons);

neuronsa=(neurons*ones(1,n_n))';
neuronsa=neuronsa(:);
neuronsb=repmat(neurons,n_n,1);
neur_nn=[neuronsa,neuronsb];
n_nn=n_n^2;
e_nn=zeros(n_n,n_n);
e_nn_a=cell(n_n,n_n);

for i_nn=1:n_nn
    disp(i_nn/n_nn);
    [e_nn(i_nn) E]=CrossValidation(matrix_data_300(:,:,neur_nn(i_nn,:),:),'mixte',1);
    e_nn_a{i_nn}=permute(sum(E,1),[1,3,2]);
end

e_nn_vect=e_nn(:);
[se_nn si_nn]=sort(e_nn_vect);
e_tot=[neur_nn(si_nn,:), se_nn];

e_nn_a=cell2mat(e_nn_a);

neurons=neurons';
save('neur_perf_26','neurons','e_tot','e_nn','e_nn_a');


