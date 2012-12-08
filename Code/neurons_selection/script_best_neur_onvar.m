%% This script is meant to give an idea of which would be the best neurons
%based on the variatins between activities for each angle.

A=zeros(98,3);
p=zeros(98,8);
sumact=sum(matrix_data_300,4);
for i_n=1:98
    act=reshape(sumact(:,:,i_n),[],1);
    g=ones(100,1)*(1:8);
    g=g(:);
    A(i_n,1)=anova1(act,g,'off');
    for i_a=1:8
        group=zeros(size(act));
        group(100*(i_a-1)+1:100*i_a)=ones(100,1);
        p(i_n,i_a)=anova1(act,group,'off');
    end
    [A(i_n,2) A(i_n,3)]=min(p(i_n,:));
end
[Aa Aan]=sort(A(:,2));
p_angle=[Aan';Aa'; A(Aan,3)'];
[At Atn]=sort(A(:,1));
p_tot=[Atn';At'];
carac_neur=A;
[~, ind5]=sort(p(:,4),1);
p_5=[ind5 p(ind5,:)];

for i=1:8
[psi ind]=sort(p(:,i));
eval(['p_angle_' num2str(i) '= [ind''; psi'']; ']);
end

save('perf_onvar','p_*','carac*')