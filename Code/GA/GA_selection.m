%% GA_selection
% Roulette selection with elitism
%
%
% Roulette selection : chromosomes are ranked in decreasing order with
% respect to the error (i.e. high rank corresponds to good performance) ;
% A new population is then constructed as follow: 'n_chr' chromosomes are
% selected ; at each selection step, chromosome ranked 'r_i'
% (1<= r_i <= n_chr) is selected with probability
% p(r_i) = r_i / sum(1:n_chr)
%
% Elistism : we make sure to retain the best chromosome of 'pop' if it is
% better than the old best (mutations improved the pop), and to retain
% 'old_best_chr' otherwise.
%
function rep = GA_selection(pop, sorted_error, index_in_error, old_best_chr, old_best_error)

n_chr = size(pop, 1);
length_chr = size(pop, 2);

new_pop = zeros(n_chr, length_chr);
p = cumsum(1:n_chr) / sum(1:n_chr);

% elitism...
if (sorted_error(n_chr) < old_best_error)
    pop_has_improved =  1;
    best_error = sorted_error(n_chr);
    best_chr = pop(index_in_error(n_chr), :);
else
    pop_has_improved =  0;
    best_error = old_best_error;
    best_chr = old_best_chr;
end
best_in_pop_was_selected = 0;
%

for i_chr = 1:n_chr
    rd = rand();
    r_sel = 1;
    while (rd > p(r_sel))
        r_sel = r_sel + 1;
    end
    % chromose ranked 'r_sel' is selected
    % it corresponds to index 'i_sel' in 'pop'
    i_sel = index_in_error(r_sel);
    
    % elitism...
    if (r_sel == n_chr)
        best_in_pop_was_selected = 1;
    end
    
    new_pop(i_chr, :) = pop(i_sel, :);
end

% elistim...
if (pop_has_improved && ~best_in_pop_was_selected)
    r_i = randi(n_chr);
    new_pop(r_i, :) = pop(index_in_error(n_chr), :);
elseif (~pop_has_improved)
    r_i = randi(n_chr);
    new_pop(r_i, :) = old_best_chr;
end
%

rep = struct('new_pop', new_pop, 'best_chr', best_chr,'best_error', best_error);

end
%%
% END
%