%% GA_initialisation
%
function pop = GA_initialisation(n_chr, length_chr, pool_neurons)

pop = zeros(n_chr, length_chr);

for i_chr = 1:n_chr
    pop(i_chr, :) = randsample(pool_neurons, length_chr);
end

%gauss
% e = 0.0862 // sum(E) = 11     2     9    15    13     5     4    10
pop(1, :) = [4     7    18    27    44    55    69    75    86    97];
% e = 0.0813 // sum(E) = 2     2    15    11    20     4     5     6
pop(2, :) = [3     6    31    34    36    44    59    75    90    97];
% e = 0.0712 // sum(E) = 5     5    14    10    10     4     3     6
pop(3, :) = [3     4    27    31    34    35    44    80    81    97]; 
% e = 0.0625 // sum(E) = 3     2     9    13     9     4     4     6
pop(4, :) = [3     4    18    27    31    36    44    80    81    97]; 
% e = 0.0600 // sum(E) = 3     3     7    11    10     4     4     6
pop(5, :) = [3     4    18    27    36    44    69    80    81    97];

% For mixed :
% e =0.0500 / gauss : e = 0.0575
pop(6, :) = [3    18    27    34    36    44    69    81    75    97];
% 
% e =0.0500 / gauss : e = 0.0625
pop(8, :) = [3    18    27    34    36    44    69    80    75    97];
%
% e =0.0488 / gauss : e = 0.0612
pop(7, :) = [3    18    27    34    36    44    69    71    75    97];
% intermediaires :
%3    18    27    34    36    44    59    69    75    80
%
%3    18    27    34    36    44    59    69    75    97
%
%3    18    27    34    36    44    69    71    75    97
%
%e = 0.04125
pop(9, :) = [3     4    27    34    36    44    59    69    75    86];

%pool complet
%3    19    27    34    36    44    56    59    69    75   %4.3775
%3    27    34    36    44    56    59    69    75    97    %4.5
%
%

% shaking...
pop(1, :) = pop(1, randperm(length_chr));
pop(2, :) = pop(2, randperm(length_chr));
pop(3, :) = pop(3, randperm(length_chr));
pop(4, :) = pop(4, randperm(length_chr));
pop(5, :) = pop(5, randperm(length_chr));
pop(6, :) = pop(6, randperm(length_chr));
pop(7, :) = pop(7, randperm(length_chr));
pop(8, :) = pop(8, randperm(length_chr));

papymamy;
pop(1:size(selec_neur,1),:)=selec_neur;


end
%%
% END
%
