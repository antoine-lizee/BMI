%% GA_mutations
%ONLY ACCEPT EVEN POPULATIONS
%
function new_pop = GA_mutations(pop, pool_neurons, p_m, p_c)

length_chr = size(pop, 2);
n_chr = size(pop, 1);
new_pop = zeros(n_chr, length_chr);

% Crossing-over
for i_chr = 1:(n_chr/2)
    
    i_chr1 = randi(n_chr);
    i_chr2 = randi(n_chr);
    
    if (rand() < p_c)
        [chr_child1, chr_child2] = GA_crossingOver3(pop(i_chr1, :)', pop(i_chr2, :)');
    else
        chr_child1 = pop(i_chr1, :);
        chr_child2 = pop(i_chr2, :);
    end
    
    new_pop(2*i_chr-1, :) = chr_child1;
    new_pop(2*i_chr, :) = chr_child2;
end

if new_pop(n_chr)==0 %odd number of chromosom
    new_pop(n_chr, :)=pop(n_chr, :);
end
    
% Mutations
for i_chr = 1:n_chr
    if (rand() < p_m)
        new_pop(i_chr, :) = GA_mutation_impl1(new_pop(i_chr, :), pool_neurons);
    end
end

end
%%
% END
%