stack=[3    18    27    34    36    44    69    81    75    97];
load('matrix_data_300');
n_a=8;
n_n=length(stack);
matrixcov=zeros(n_n,n_n,n_a);
sum_act=sum(matrix_data_300(:,:,stack,:),4);
cova=zeros(n_n,n_n,n_a);
cova_test=cova;
cova_true=cova;
for i_a=1:n_a
    [cova(:,:,i_a) cova_test(:,:,i_a) cova_true(:,:,i_a)]=cov_trunc(sum_act(:,i_a,:),1);
end
[cdf val]=ksdensity(abs(cova_test(:)),'function','cdf');
plot(val,cdf)
[pdf val]=ksdensity(abs(cova_test(:)));%,'function','cdf');
figure(2);plot(val,pdf)
figure(3);hist(abs(cova_test(:)),50);
disp(['final sparse ratio of ' num2str((nnz(cov)-n_n*n_a)/(nnz(cova_test)-n_n*n_a)) ' considering covariances' ])