%% GA_evaluation
% pop is the matrix n_chr x length(chr)
% of the population of chromosomes
%
function error = GA_evaluation(pop, matrix_data_300,method)
n_chr = size(pop, 1);
error = zeros(n_chr, 1);

parfor i_chr = 1:n_chr
    [e, ~] = CrossValidation(matrix_data_300(:, :, pop(i_chr,:), :), method, 1);
    error(i_chr) = e;
end
%%
% END
%
