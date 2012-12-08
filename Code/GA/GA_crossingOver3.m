%% GA_crossingOver2
%
%
function [chr_child1 chr_child2] = GA_crossingOver3(chr1, chr2)
l_c=length(chr1);
n=randi(floor(l_c/2));

[~, interind1 interind2]=intersect(chr1, chr2);

ind1=1:l_c;
ind1(interind1)=[];

ind2=1:l_c;
ind2(interind2)=[];

n=min([n,length(ind2)]);

indchr1=randsample(ind1,n);
indchr2=randsample(ind2,n);
neurtemp=chr1(indchr1);
chr1(indchr1)=chr2(indchr2);
chr2(indchr2)=neurtemp;

chr_child1=chr1;
chr_child2=chr2;




end

%%
% END
%
