%% Genetic Algorithm
%
%

function rep = GA(n_gen, n_chr, length_chr, p_m, p_c, pool_neurons, matrix_data_300,method,par_core)

disp('Starting GA...');

if nargin<8
    disp('...using gauss ,ethod because no input specified...');
    method='gauss';
end

if nargin<9
    disp('...parallel processing disabled by default...');
    par_core=1;
end

if par_core==0 % Default parallel processing
    matlabpool;
elseif par_core~=1
    matlabpool(par_core);
end

% Keeping track of the best chromosome and its performance
best_chrs = zeros(n_gen+1, 10);
best_errors = zeros(n_gen+1, 1);
pop_hist=zeros(n_gen+1, 10, n_chr);

% Initialisation
pop = GA_initialisation(n_chr, length_chr, pool_neurons);
pop_hist(1,:,:)=permute(pop,[3 2 1]);

% First evaluation
error = GA_evaluation(pop, matrix_data_300,method);

% First sort
[sorted_error, index_in_error] = sort(error, 'descend');
old_best_chr = pop(index_in_error(n_chr),:);
old_best_error = sorted_error(n_chr);


%%
for i_gen = 1:n_gen
    
    % Roulette selection with elitism
    new_set = GA_selection(pop, sorted_error, index_in_error, old_best_chr, old_best_error);
    pop = new_set.new_pop;
    
    old_best_chr = new_set.best_chr;
    old_best_error = new_set.best_error;
    
    % output in console
    disp('* * *');
    disp(['Gen ', num2str(i_gen-1), ' ; best error = ', num2str(old_best_error)]);
    display(old_best_chr);
    %
    
    pop_hist(i_gen,:,:)=permute(pop,[3 2 1]);
    best_chrs(i_gen, :) = new_set.best_chr;
    best_errors(i_gen) = new_set.best_error;
    
    % Mutations and Crossing-over
    pop = GA_mutations(pop, pool_neurons, p_m, p_c);
    
    % Evaluation
    error = GA_evaluation(pop, matrix_data_300,method);
    [sorted_error, index_in_error] = sort(error, 'descend');
    save('backup','best_chrs','best_errors','pop_hist');
end

% Last best
if (sorted_error(n_chr) < old_best_error)
    best_chrs(n_gen + 1, :) = pop(index_in_error(n_chr));
    best_errors(n_gen + 1) = sorted_error(n_chr);
else
    best_chrs(n_gen + 1, :) = old_best_chr;
    best_errors(n_gen + 1) = old_best_error;
end

% output in console
disp('* * *');
disp(['Gen ', num2str(n_gen), ' ; error = ', num2str(best_errors(n_gen + 1))]);
best_chrs(n_gen + 1, :)
disp('DONE !');
%
%%

rep = struct('best_chrs', best_chrs, 'best_errors', best_errors,'pophist', pop_hist, 'lastpop', permute(pop_hist(end,:,:), [3 2 1]));

if par_core~=1
    matlabpool close force;
end

end
%%
% END
%