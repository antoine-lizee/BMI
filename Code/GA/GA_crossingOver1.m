%%
%
%
function [chr_child1 chr_child2] = GA_crossingOver1(chr1, chr2)

i_cut = randi([2,length(chr1)-1]);

chr_child1 = [chr1(1:i_cut); chr2((i_cut+1):length(chr1))];
chr_child2 = [chr2(1:i_cut); chr1((i_cut+1):length(chr1))];

end

%%
% END
%