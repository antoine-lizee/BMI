
n_gen = 100;
n_chr = 50;
length_chr = 10;
p_m = 0.5;
p_c = 0.4;
pool_neurons = 1:98; %poolNeurons;
method='multi';
rep1=cell(4,1);
for i=1:4
    elapsed_CPU_time = cputime;
    rep1{i}=GA(n_gen, n_chr, length_chr, p_m, p_c, pool_neurons, matrix_data_300,method,2)
    % disp('decreasing temperature...');
    % rep2=GA(n_gen, n_chr, length_chr, p_m-0.1, p_c-0.1, pool_neurons, matrix_data_300,method,0)
    elapsed_CPU_time = cputime - elapsed_CPU_time
    save('rep','rep1')
end


% cos
% 36    44    27    31    84    69    33     7    87     3  % 0.48125
% cos
% 27    97    36     4     3    69    59    44     7    75 % 0.47375
%
% 4    18    34     7    27     3    33    36    97    59 % 0.45625
