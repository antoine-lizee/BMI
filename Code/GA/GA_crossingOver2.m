%% GA_crossingOver2
%
%
function [chr_child1 chr_child2] = GA_crossingOver2(chr1, chr2)

length_chr = length(chr1);
pool = unique([chr1 chr2]);

chr_child1 = randsample(pool, length_chr);
chr_child2 = randsample(pool, length_chr);

end

%%
% END
%