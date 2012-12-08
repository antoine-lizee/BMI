%% GA_mutation_impl2
%
%
function mut_chr = GA_mutation_impl2(chr, pool_neurons)

length_chr = length(chr);
n_neur = length(pool_neurons);

i_mut = randi(length_chr);

mut_neur_is_in_chr = 1;

% makes sure that the mutation is not adding a neuron that was already in
% the chromosome
while(mut_neur_is_in_chr)
    i_neur = 1;
    mut_neur = pool_neurons(randi(n_neur));
    
    while (i_neur <= length_chr && chr(i_neur) ~= mut_neur)
        i_neur = i_neur + 1;
    end
    
    if (i_neur > length_chr )
        mut_neur_is_in_chr = 0;
    end
    
end

mut_chr(i_mut) = mut_neur;

end
%%
% END
%
