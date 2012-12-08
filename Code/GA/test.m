
n_test = 10;

times = zeros(1, n_test);
perf = zeros(1, n_test);

for i_test = 1:n_test

neurons = randsample(1:98, 10);
t = cputime;
[e, ~] =  CrossValidation(matrix_data_300(:,:,neurons,:), 'gauss', 1);
perf(i_test) = e;
times(i_test) = cputime - t;

end

times
mean(times)
std(times)

perf