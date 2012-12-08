%% GA_mutation_impl1
%
%
function mut_chr = GA_mutation_impl1(chr, pool_neurons)

length_chr = length(chr);
n_neur = length(pool_neurons);

i_mut = randi(length_chr);
i_neur = randi(n_neur);

mut_chr = chr;
mut_chr(i_mut) = pool_neurons(i_neur);

end
%%
% END
%