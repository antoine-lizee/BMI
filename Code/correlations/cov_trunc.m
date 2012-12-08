function [ matrix mat_test matrixcov stack2 groups ] = cov_trunc( sum_act, thre )
%CORRELATIONS compute correlations from the provided summed activity of the
%neurons. sum_act must be a n_t x 1 x n_n matrix
%   Detailed explanation goes here


matrixcov(:,:)=cov(permute(sum_act,[1 3 2]));


matrix=matrixcov;
matrixnorm=zeros(size(matrix));
for i=1:size(matrix,3)
    matrixnorm(:,:,i)=sqrt(diag(matrix(:,:,i))*diag(matrix(:,:,i))');
end
mat_test=matrixcov./matrixnorm;
bool=(abs(mat_test)<thre);
for i=1:size(bool,3), bool(:,:,i)=xor(bool(:,:,i),diag(diag(bool(:,:,i)))); end
matrix(bool)=0;


end

